"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
if has('vim_starting')
  set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'bronson/vim-trailing-whitespace'
Plug 'scrooloose/syntastic'
Plug 'Yggdroot/indentLine'
Plug 'lifepillar/vim-mucomplete'
Plug 'tomasr/molokai'  " Color
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jelera/vim-javascript-syntax'
Plug 'mbbill/undotree'
Plug 'vimwiki/vimwiki'
Plug 'skywind3000/asyncrun.vim'
"Plug 'hashivim/vim-terraform'
Plug 'davidhalter/jedi-vim'
"" Go Lang Bundle
if executable("go")
    Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
endif

let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
        let g:make = 'make'
endif


"" Completion
set completeopt-=preview
set completeopt+=menuone,noinsert
set shortmess+=c
let g:mucomplete#enable_auto_at_startup = 1

"*****************************************************************************

"" Include user's extra bundle
if filereadable(expand("~/.config/nvimrc.local.bundles"))
  source ~/.config/nvimrc.local.bundles
endif

call plug#end()

" Required:
filetype plugin indent on

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Every wrapped line will continue visually indented (same amount of
set breakindent

"" Path
set path+=**
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary
set wildignore=*.swp,*.bak,*.pyc,*.class

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Map leader to ,
let mapleader=','
let maplocalleader=';'

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Directories for swp files
set nobackup
set swapfile
set undofile

set fileformats=unix,dos,mac
set showcmd
set shell=/bin/bash

" Activate the incremental (live) substitution
set inccommand=split

" Deactivate the arrow keys
noremap <left> <nop>
noremap <right> <nop>
noremap <up> <nop>
noremap <down> <nop>

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set synmaxcol=200
set number
set mouse=v

let no_buffers_menu=1
if !exists('g:not_finish_vimplug')
    let g:molokai_original = 1
    let g:rehash256 = 1
    colorscheme molokai
endif

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '┆'
let g:indentLine_faster = 1

"" Disable the blinking cursor.
set scrolloff=3

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
" Edit my nvim configuration
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" Reload nvim configuration
nnoremap <leader>sv :source $MYVIMRC<cr>

" Terminal settings
tnoremap <Leader><ESC> <C-\><C-n>

" Expand the current directory
ab <expr> %% expand('%:p:h')

nnoremap <F2> :Vexplore<CR>
nnoremap <F3> :Vexplore .<CR>

"" UndoTree toggle
noremap <leader>z :UndotreeToggle<CR>
if has("persistent_undo")
    "set undodir=~/.undodir/
    set undofile
endif

" grep.vim
nnoremap <silent> <leader>f :Regrep<CR>
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

" spell checking
function! ToggleSpellLang()
    " toggle between en and fr
    if &spelllang =~# 'en'
        :set spelllang=fr
    else
        :set spelllang=en
    endif
endfunction
" toggle spell on or off
nnoremap <F4> :setlocal spell!<CR>
" toggle language
nnoremap <F5> :call ToggleSpellLang()<CR>

"*****************************************************************************
"" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" The PC is fast enough, do syntax highlight syncing from start
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync fromstart
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

" Set the filetype to yaml for salt's `.sls` extension
au BufRead,BufNewFile *.sls set filetype=yaml

set autoread

"*****************************************************************************
"" Mappings
"*****************************************************************************
" sudo before saving the file
cmap w!! w !sudo tee > /dev/null %<CR><CR>

"" Split
noremap <leader>h :<C-u>split<CR>
noremap <leader>v :<C-u>vsplit<CR>

"" Set working directory
noremap <leader>. :lcd %:p:h<CR>

"" fzf shortcut
noremap <Leader>h :History<CR>
noremap <leader>b :Buffers<CR>
noremap <leader>l :Lines<CR>
noremap <leader>e :Files<CR>
noremap <Leader>f :Ag<CR>
noremap <Leader>d :exe ':Ag ' . expand('<cword>')<CR>
nnoremap <leader><leader> :Commands<CR>


" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1

let g:syntastic_auto_loc_list = 2
let g:syntastic_python_checkers=['python', 'flake8']
    let g:syntastic_mode_map = {
        \ "mode": "passive",
        \ "active_filetypes": [],
        \ "passive_filetypes": [] }

" Disable visualbell
set noerrorbells visualbell t_vb=

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard+=unnamedplus
endif


if executable('xclip')
  " xclip for linux copy/paste
  vmap <C-x> :!xclip<CR>
  vmap <C-c> :'<,'>w !xclip<CR><CR>
endif

"" Close buffer
noremap <leader>c :bd<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Vmap for maintain Visual Mode after shifting > and <
vnoremap < <gv
vnoremap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"*****************************************************************************
"" Custom configs
"*****************************************************************************

" vim-go
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_metalinter_autosave = 1

if executable("go")
    augroup FileType go
      autocmd!
      autocmd FileType go nmap <localleader>d <Plug>(go-def)
      autocmd FileType go nmap <localleader>k <Plug>(go-doc)
      autocmd FileType go nmap <localleader>dv <Plug>(go-def-vertical)
      autocmd FileType go nmap <localleader>kv <Plug>(go-doc-vertical)
      autocmd FileType go nmap <localleader>kb <Plug>(go-doc-browser)
      autocmd FileType go nmap <localleader>i <Plug>(go-info)
      autocmd FileType go nmap <localleader>r <Plug>(go-run)
      autocmd FileType go nmap <localleader>b <Plug>(go-build)
      autocmd FileType go nmap <localleader>t <Plug>(go-test)
    augroup END
endif

" javascript
let g:javascript_enable_domhtmlcss = 1

" vim-javascript
augroup vimrc-javascript
  autocmd!
  autocmd FileType javascript set tabstop=4|set shiftwidth=4|set expandtab softtabstop=4 smartindent
augroup END

" python
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
      \ formatoptions+=croq softtabstop=4 smartindent
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#goto_definitions_command = "<localleader>d"
let g:jedi#goto_assignments_command = "<localleader>g"
let g:jedi#documentation_command = "<localleader>k"
let g:jedi#usages_command = "<localleader>n"
let g:jedi#rename_command = "<localleader>r"
let g:jedi#completions_command = "<C-Space>"

" *******************************************
" vimwiki
" *******************************************
let g:vimwiki_list = [{'path': '~/vimwiki/',  'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.mkd': 'markdown', '.wiki': 'media'}



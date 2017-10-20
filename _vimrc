"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
if has('nvim')
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
else
    let vimplug_exists=expand('~/.vim/autoload/plug.vim')

    if !filereadable(vimplug_exists)
        echo "Installing Vim-Plug..."
        echo ""
        silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        let g:not_finish_vimplug = "yes"

        autocmd VimEnter * PlugInstall
    endif

    " Required:
    call plug#begin(expand('~/.vim/plugged'))
endif

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
" Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'bronson/vim-trailing-whitespace'
Plug 'Yggdroot/indentLine'
Plug 'tomasiser/vim-code-dark'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vimwiki/vimwiki'
" Go Lang Bundle
if executable('go')
    Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
endif

if has('nvim')
    " Plug 'davidhalter/jedi-vim'
    Plug 'neomake/neomake'

    if executable("flake8") && executable("pep8")
        let g:neomake_python_enabled_makers = ['flake8', 'pep8',]
        let g:neomake_python_flake8_maker = { 'args': ['--ignore=E115,E266,E501'], }
        let g:neomake_python_pep8_maker = { 'args': ['--max-line-length=100', '--ignore=E115,E266'], }
    endif
    autocmd! BufWritePost * Neomake

    if has("python3")
        Plug 'roxma/nvim-completion-manager'
        Plug 'roxma/python-support.nvim'
        let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'jedi')
        let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'mistune')
        let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'psutil')
        let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'setproctitle')
    endif
if executable("npm")
    " (optional) javascript completion
    Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
endif
endif


"" Completion
set shortmess+=c
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


"*****************************************************************************
call plug#end()

"" Required:
filetype plugin indent on

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Every wrapped line will continue visually indented
set breakindent

"" Path
set path+=**
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
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
set ignorecase
set smartcase

"" Directories for swp files
set nobackup
set swapfile
set undofile
if !isdirectory($HOME."/.undodir")
    call mkdir($HOME."/.undodir", "", 0700)
endif
set undodir=~/.undodir/


set fileformats=unix,dos,mac
set showcmd
set shell=/bin/bash

"*****************************************************************************
"" Nvim specific
"*****************************************************************************
if has('nvim')
    " Activate the incremental (live) substitution
    set inccommand=split
    set incsearch
    " Terminal settings
    tnoremap <Leader><ESC> <C-\><C-n>
endif


"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set number
set mouse=v

let no_buffers_menu=1
if !exists('g:not_finish_vimplug')
    set t_Co=256
    set t_ut=
    colorscheme codedark
endif

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '┆'
let g:indentLine_faster = 1

set scrolloff=5

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
" Expand the current directory
ab <expr> %% expand('%:p:h')

iab #! #!/usr/bin/env
iab @@ yann.malet@gmail.com

"*****************************************************************************
"" Mappings
"*****************************************************************************
" Edit my nvim configuration
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" Reload nvim configuration
nnoremap <leader>sv :source $MYVIMRC<cr>

" File explorer
nnoremap <F2> :Vexplore<CR>
nnoremap <F3> :Vexplore .<CR>

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


" sudo before saving the file
cmap w!! w !sudo tee > /dev/null %<CR><CR>

"" Split
noremap <leader>v :<C-u>vsplit<CR>
noremap <leader>s :<C-u>split<CR>

"" fzf shortcut
noremap <Leader>h :History<CR>
noremap <leader>b :Buffers<CR>
noremap <leader>l :Lines<CR>
noremap <leader>e :Files<CR>
noremap <Leader>f :Ag<CR>
noremap <Leader>ff :exe ':Ag ' . expand('<cword>')<CR>
nnoremap <leader><leader> :Commands<CR>

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

"" Copy/Paste/Cut
if has('unnamedplus')
    set clipboard+=unnamedplus
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

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" Remember cursor position
augroup vimrc-remember-cursor-position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
    autocmd!
    autocmd BufRead,BufNewFile *.txt setlocal filetype=markdown wrap textwidth=100 wrapmargin=4

augroup END

" vim-javascript
augroup vimrc-javascript
    autocmd!
    autocmd FileType javascript setlocal tabstop=4 shiftwidth=4 expandtab softtabstop=4 smartindent
augroup END

" python
augroup vimrc-python
    autocmd!
    autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
    autocmd FileType python setlocal formatoptions+=croq softtabstop=4 smartindent
    autocmd FileType python setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" markdown
augroup vimrc-markdown
    autocmd!
    autocmd BufNewFile,BufReadPost *.md setlocal filetype=markdown wrap textwidth=100 wrapmargin=4
augroup END

"" make/cmake
augroup vimrc-make-cmake
    autocmd!
    autocmd FileType make setlocal noexpandtab
    autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

" Set the filetype to yaml for salt's `.sls` extension
au BufRead,BufNewFile *.sls set filetype=yaml

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

" Reload the file if it has been changed outside vim
set autoread

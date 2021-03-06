"*****************************************************************************
" Vim-PLug core
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
" Plug install packages
"*****************************************************************************
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'Yggdroot/indentLine'
Plug 'tomasiser/vim-code-dark'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
if has("nvim")
    Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
    Plug 'vimwiki/vimwiki'
    Plug 'sgur/vim-editorconfig'
endif
if has("nvim-0.3.0") 
    Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
endif

call plug#end()
"*****************************************************************************
" LSP completion
"*****************************************************************************"
" coc requires at least nvim 0.3.0
if has("nvim-0.3.0")
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> for trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use `[c` and `]c` for navigate diagnostics
    nmap <silent> <LEFT> <Plug>(coc-diagnostic-prev)
    nmap <silent> <RIGHT> <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K for show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if &filetype == 'vim'
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Highlight symbol under cursor on CursorHold
    " autocmd CursorHold * silent call CocActionAsync('highlight')

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

    " Remap for format selected region
    vmap <leader>cf  <Plug>(coc-format-selected)
    nmap <leader>cf  <Plug>(coc-format-selected)

    " Setup formatexpr specified filetype(s).
    augroup mygroup
      autocmd!
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    augroup end

    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    vmap <leader>ca  <Plug>(coc-codeaction-selected)
    nmap <leader>ca  <Plug>(coc-codeaction-selected)

    " Remap for do codeAction of current line
    nmap <leader>cac  <Plug>(coc-codeaction)

    " Use `:Format` for format current buffer
    command! -nargs=0 CocFormat :call CocAction('format')

    " Use `:Fold` for fold current buffer
    command! -nargs=? CocFold :call     CocAction('fold', <f-args>)
    command! -nargs=0 CocPrettier :CocCommand prettier.formatFile

    " Using CocList
    " Show all diagnostics
    nnoremap <silent> <space>d  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Resume latest coc list
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
endif

"*****************************************************************************"
" gutter plugin
"*****************************************************************************"
" Always show up the sign column
if has("signcolumn")
    set signcolumn="yes"
endif


"*****************************************************************************
" Completion
"*****************************************************************************"

"set completeopt-=preview
set shortmess+=co
"*****************************************************************************
" Basic Setup
"*****************************************************************************"
filetype plugin indent on
" Every wrapped line will continue visually indented
set breakindent

" Highlight the cursorline
set cursorline

" Reload the file if it has been changed outside vim
set autoread


" Path
set path=.,,**
if !empty($VIRTUAL_ENV)
    set path+=$VIRTUAL_ENV/lib/**
endif

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set wildignore=*.swp,*.bak,*.pyc,*.class
set wildmode=list:longest,full

" Fix backspace indent
set backspace=indent,eol,start

" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

" Map leader to ,
let mapleader= '&'
let maplocalleader=','

" Enable hidden buffers
set hidden

" Searching
set incsearch
set hlsearch
set ignorecase
set smartcase

" Directories for swp files
set nobackup
set swapfile
set undofile
if !isdirectory($HOME."/.undodir")
    call mkdir($HOME."/.undodir", "", 0700)
endif
set undodir=~/.undodir/


set fileformats=unix,dos,mac
set showcmd
set cmdheight=2
set shell=/bin/bash

"*****************************************************************************
" Nvim specific
"*****************************************************************************
if has('nvim')
    " Activate the incremental (live) substitution
    set inccommand=split
endif

"*****************************************************************************
" Visual Settings
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

" Statusline definition 
set statusline=                                 " Clear
set statusline+=%{pathshorten(expand('%'))}     " Tail of the filename
set statusline+=%h                              " Help file flag
set statusline+=%r                              " Read only flag
set statusline+=%m                              " Modified flag
set statusline+=%=                              " Left/right separator
set statusline+=\ \                             " --
set statusline+=%{&filetype}                    " Filetype
set statusline+=\ \                             " --
set statusline+=%{&fenc}                        " File encoding
set statusline+=[%{&ff}]                        " File format
set statusline+=[                               " Indent settings: begin
set statusline+=%{&expandtab?\"sp\":\"tab\"}\   " Indent settings
set statusline+=%{&shiftwidth}                  " Indent settings
set statusline+=]                               " Indent settings: end
set statusline+=\ \                             " --
set statusline+=col:\ \%2c                      " Cursor column
set statusline+=\ \                             " --
set statusline+=line:\ \%l\/\%L                 " Cursor line/total lines
set statusline+=\ \                             " --
set statusline+=%P                              " Percent through file

"*****************************************************************************
" Abbreviations
"*****************************************************************************
" Expand the current directory
ab <expr> %% expand('%:p:h')
iab #! #!/usr/bin/env
iab @@ yann.malet@gmail.com

"*****************************************************************************
" functions
"*****************************************************************************
function! s:FixWhitespace(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\\\@<!\s\+$//'
    call setpos('.', l:save_cursor)
endfunction

" Toggle spell checking
function! s:ToggleSpellLang()
    " toggle between en and fr
    if &spelllang =~# 'en'
        :set spelllang=fr
    else
        :set spelllang=en
    endif
endfunction

function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction

if has("nvim")
    " Open the terminal window at the bottom in nvim
    let s:term_buf = 0
    let s:term_win = 0

    function! TermToggle(height)
        if win_gotoid(s:term_win)
            hide
        else
            new terminal
            exec "resize ".a:height
            try
                exec "buffer ".s:term_buf
                exec "bd terminal"
            catch
                call termopen($SHELL, {"detach": 0})
                let s:term_buf = bufnr("")
                setlocal nonu nornu scl=no nocul
            endtry
            startinsert!
            let s:term_win = win_getid()
        endif
    endfunction


endif
"*****************************************************************************
" Commands
"*****************************************************************************
" Run :FixWhitespace to remove end of line white space
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)

" Run :Agraw to pass additional parameters to :Ag
command! -nargs=+ -complete=file Agraw call fzf#vim#ag_raw(<q-args>)

"*****************************************************************************
" Mappings
"*****************************************************************************
" Remap escape
imap ii <ESC>

" Edit my nvim configuration
nnoremap <leader>vo :vsplit $MYVIMRC<cr>
" Reload nvim configuration
nnoremap <leader>vl :source $MYVIMRC<cr>

" File explorer
nnoremap <F2> :Vexplore<CR>
nnoremap <F3> :Vexplore .<CR>

" toggle spell on or off
nnoremap <F4> :setlocal spell!<CR>
" toggle language
nnoremap <F5> :call <SID>ToggleSpellLang()<CR>

if has("nvim")
    " termninal
    nnoremap <silent><F9> :call TermToggle(20)<CR>
    inoremap <silent><F9> <Esc>:call TermToggle(20)<CR>
    tnoremap <silent><F9> <C-\><C-n>
    tnoremap <silent><F9><F9> <C-\><C-n>:call TermToggle(20)<CR>
endif

" sudo before saving the file
cmap w!! w !sudo tee > /dev/null %<CR><CR>

" fzf shortcut
let g:fzf_commits_log_options = '--graph --color=always
  \ --format="%C(yellow)%h%C(red)%d%C(reset)
  \ - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'

nnoremap <Leader>fh :History<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <C-p> :Files<CR>
nnoremap <leader>fc  :Commits<CR>
noremap <Leader>fw :exe ':Ag ' . expand('<cword>')<CR>
noremap <Leader>f :Ag<CR>
nnoremap <leader><leader> :Commands<CR>

" snippets
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" Copy/Paste/Cut
if has('unnamedplus')
    set clipboard+=unnamedplus
endif

" Close buffer
noremap <leader>q :bd<CR>

" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

" Vmap for maintain Visual Mode after shifting > and <
vnoremap < <gv
vnoremap > >gv

"*****************************************************************************
" Custom configs
"*****************************************************************************

" vim-go
let g:go_version_warning = 0
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_metalinter_autosave = 1

" *******************************************
" vimwiki
" *******************************************
let g:vimwiki_list = [{'path': '~/vimwiki/',  'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.mkd': 'markdown', '.wiki': 'media'}

"*****************************************************************************
" Autocmd Rules
"*****************************************************************************
" txt
augroup vimrc-wrapping
    autocmd!
    autocmd BufRead,BufNewFile *.txt setlocal filetype=markdown wrap textwidth=100 wrapmargin=4
augroup END

augroup vimrc-BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" vim-javascript
augroup vimrc-javascript
    autocmd!
    autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 expandtab softtabstop=4
augroup END

" vim-vue
augroup vimrc-vue
    autocmd!
    autocmd FileType vue setlocal tabstop=4 shiftwidth=2 expandtab softtabstop=2
augroup END

" vim-html
augroup vimrc-html
    autocmd!
    autocmd FileType html setlocal tabstop=4 shiftwidth=2 expandtab softtabstop=2
augroup END
let g:html_indent_script1 = 'inc'
let g:html_indent_style1  = 'inc'
let g:html_indent_inctags = 'html,body,head,tbody,p,li,dd,dt,h1,h2,h3,h4,h5,h6,blockquote,section,script,style'


" python
augroup vimrc-python
    autocmd!
    autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
    autocmd FileType python setlocal formatoptions+=croq softtabstop=4
    autocmd FileType python setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" GITCOMMIT
augroup vimrc-gitcommit
    autocmd!
    autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
    autocmd FileType gitcommit setlocal spell
augroup END


" markdown
augroup vimrc-markdown
    autocmd!
    autocmd BufNewFile,BufReadPost *.md setlocal spell filetype=markdown wrap textwidth=100 wrapmargin=4
augroup END

" make/cmake
augroup vimrc-make-cmake
    autocmd!
    autocmd FileType make setlocal noexpandtab
    autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END


" GO
augroup vimrc-go
    autocmd!
    autocmd FileType go nmap <silent> gd <Plug>(go-def)
    autocmd FileType go nmap <silent> gk <Plug>(go-doc)
    autocmd FileType go nmap <silent> gdv <Plug>(go-def-vertical)
    autocmd FileType go nmap <silent> gkv <Plug>(go-doc-vertical)
    autocmd FileType go nmap <silent> gkb <Plug>(go-doc-browser)
    autocmd FileType go nmap <silent> gi <Plug>(go-info)
augroup END


" gopass
augroup virmc-gopass
    autocmd!
    au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile
augroup END

" Set the filetype to yaml for salt's `.sls` extension
au BufRead,BufNewFile *.sls set filetype=yaml
"
" htmldjango
augroup virmc-htmldjango
    autocmd!
    autocmd FileType htmldjango setlocal tabstop=2 shiftwidth=2 expandtab softtabstop=2
    autocmd FileType htmldjango :iabbrev <buffer> {% {%  %}<left><left><left>
    " } this is just to make syntax highlight happy
    autocmd FileType htmldjango :iabbrev <buffer> {{ {{  }}<left><left><left>
    " }} this is just to make syntax highlight happy
augroup END


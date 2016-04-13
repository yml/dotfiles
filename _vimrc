" ==========================================================
" Plugins included
" ==========================================================
" Pathogen
"     Better Management of VIM plugins
"
" ==========================================================
" Performance optimization on large file
" ==========================================================
set nocursorcolumn
syntax sync minlines=256
set re=1
" ==========================================================
" Shortcuts
" ==========================================================
set pastetoggle=<F2>          "toggle between paste mode (and nopaste mode)

" Search the current word in all the file recursively
:map <F3> :execute "vimgrep /" . expand("<cword>") . "/j **"<Bar>cw<CR>

set nocompatible              " Don't be compatible with vi
let mapleader=","             " change the leader to be a comma vs slash

"remap increment to Ctrl-I because ctrl+a clash with tmux
:nnoremap <C-I> <C-A>

" Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w

" ,v brings up my .vimrc
" ,V reloads it -- making all changes active (have to save first)
map <leader>vi :sp ~/.vimrc<CR><C-W>_
map <silent> <leader>VI :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" open/close the quickfix window
nmap <leader>co :copen<CR>
nmap <leader>cc :cclose<CR>

" for when we forget to use sudo to open/edit a file
cmap w!! w !sudo tee % >/dev/null

" Load the Gundo window
map <leader>z :GundoToggle<CR>

" Vertical split
map <leader>/ :vsplit<CR>

" Horizontal split
map <leader>- :split<CR>

" Expand the current directory
ab <expr> %% expand('%:p:h')
" ==========================================================
" Pathogen - Allows us to organize our vim plugins
" ==========================================================
" Load pathogen with docs for all plugins
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" ==========================================================
" Basic Settings
" ==========================================================
filetype on                   " try to detect filetypes
filetype plugin indent on     " enable loading indent file for filetype
filetype plugin on
set hidden                    " hide buffers instead of closing them
set mouse=a                   " enable mouse
set number                    " Display line numbers
set numberwidth=1             " using only 1 column (and 1 space) while possible
set relativenumber            " Display the relative number
set background=dark           " We are using dark background in vim
set title                     " show title in console title bar
set wildmenu                  " Menu completion in command mode on <Tab>
set wildmode=full             " <Tab> cycles between all matching choices.
set wrap                      " wrap tells Vim to word wrap visually

" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc

" show a line at column 79
if exists("&colorcolumn")
    set colorcolumn=79
endif

""" Moving Around/Editing
set nocursorline            " have a line indicate the cursor location
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=3             " Keep 3 context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set showmatch               " Briefly jump to a paren once it's balanced
set matchtime=10             " (for only .2 seconds).
set linebreak               " don't wrap textin the middle of a word
set autoindent              " always set autoindenting on
set tabstop=4               " <tab> inserts 4 spaces
set shiftwidth=4            " but an indent level is 2 spaces wide.
set softtabstop=4           " <BS> over an autoindent deletes both spaces.
set expandtab               " Use spaces, not tabs, for autoindent/tab key.
set shiftround              " rounds indent to a multiple of shiftwidth
set matchpairs+=<:>         " show matching <> (html mainly) as well
set foldmethod=indent       " allow us to fold on indents
set foldlevel=9             " don't use fold by default

" close preview window automatically when we move around
" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"""" Reading/Writing
set noautowrite             " Never write a file unless I request it.
set noautowriteall          " NEVER.
set noautoread              " Don't automatically re-read changed files.
set modeline                " Allow vim options to be embedded in files;
set modelines=5             " they must be within the first or last 5 lines.
set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.

"""" Messages, Info, Status
set ls=2                    " allways show status line
set vb t_vb=                " Disable all bells.  I hate ringing/flashing.
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
set laststatus=2            " Always show statusline, even if only 1 window.

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>-,trail:-,precedes:<,extends:>
set nolist

""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

"""" Display
syntax on                   " Syntax highlighting
"colorscheme vividchalk
colorscheme inkpot
"colorscheme corporation

" ==========================================================
" Python
" ==========================================================
" Run pep8
let g:pep8_map='<leader>8'

" Don't let pyflakes use the quickfix window
let g:pyflakes_use_quickfix = 0

" turn of hlsearch and update pyflakes on enter
au BufRead,BufNewFile *.py nnoremap <buffer><CR> :nohlsearch\|:call PressedEnter()<cr>
nnoremap <buffer><CR> :nohlsearch\|:call PressedEnter()<cr>

" clear the search buffer when hitting return and update pyflakes checks
function! PressedEnter()
    :nohlsearch
    if &filetype == 'python'
        :PyflakesUpdate
    end
endfunction

" jedi-vim plugin
let g:jedi#show_call_signatures = 0
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 1
" set the following setting to 1 if you want python completion
let g:jedi#auto_initialization = 1

" ==========================================================
" GO
" ==========================================================
let g:go_disable_autoinstall = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 0

let g:go_fmt_command = "goimports"
let g:go_bin_path = expand("~/gopath")

au FileType go nmap <Leader>gs <Plug>(go-implements)
au FileType go nmap <Leader>gd <Plug>(go-def)
au FileType go nmap <Leader>gi <Plug>(go-info)
au FileType go nmap <Leader>gh <Plug>(go-doc)
au FileType go nmap <leader>gr <Plug>(go-run)
au FileType go nmap <leader>gb <Plug>(go-build)
au FileType go nmap <leader>gt <Plug>(go-test)
au FileType go nmap <leader>gc <Plug>(go-coverage)

let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
" ==========================================================
" Javascript
" ==========================================================
au BufRead *.js set makeprg=jslint\ %

" ==========================================================
" Trailing Space Helpers
" ==========================================================
" Highlight Trailing Space
highlight TrailingWhitespace ctermbg=darkgreen guibg=darkgreen
match TrailingWhitespace /\s\+$/
au TabEnter * :match TrailingWhitespace /\s\+$/

" Trailing space removal on save
function! StripTrailingSpaces()
    let l = line(".")
    let c = col(".")
    silent! execute '%s/\s\+$//e'
    call cursor(l, c)
endfunction

" ==========================================================
" supertab
" ==========================================================
let g:SuperTabDefaultCompletionType = "context"

" ==========================================================
" spell checking
" ==========================================================
" set spell spelllang=en_us

function! ToggleSpellLang()
    " toggle between en and fr
    if &spelllang =~# 'en'
        :set spelllang=fr
    else
        :set spelllang=en
    endif
endfunction
nnoremap <F3> :setlocal spell!<CR> " toggle spell on or off
nnoremap <F4> :call ToggleSpellLang()<CR> " toggle language
" ==========================================================
" Unite
" ==========================================================
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files -start-insert file_rec/async:!<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru -start-insert file_mru<cr>
nnoremap <leader>b :<C-u>Unite -no-split -quick-match -buffer-name=buffer buffer<cr>
nnoremap <leader>f :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank history/yank<cr>

" pt is go program that is comparable to grep but faster
" go get https://github.com/monochromegane/the_platinum_searcher
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_encoding = 'utf-8'
endif

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

" ==========================================================
" neocomplete
" ==========================================================
let g:neocomplete#enable_at_startup = 1

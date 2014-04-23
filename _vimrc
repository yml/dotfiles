" https://github.com/ym/dotfiles/
" ==========================================================
" Dependencies - Libraries/Applications outside of vim
" ==========================================================
" Python 
"
" Pep8 - http://pypi.python.org/pypi/pep8
" Pyflakes
"
" Go
"
" go get code.google.com/p/go.tools/cmd/...
" go get-u github.com/nsf/gocode
" go get -u code.google.com/p/rog-go/exp/cmd/godef

" ==========================================================
" Plugins included
" ==========================================================
" Pathogen
"     Better Management of VIM plugins
"
" GunDo
"     Visual Undo in vim with diff's to check the differences
"
" Snipmate
"     Configurable snippets to avoid re-typing common comands
"
" PyFlakes
"     Underlines and displays errors with Python on-the-fly
"
" Minibufexpl
"    Visually display what buffers are currently opened
"
" NerdTree
"    The NERD tree allows you to explore your filesystem and to open files and 
"    directories.
"
" pep8
"    It's a simple program that just checks if your python code is pep-8
"    compliant.
"
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

" Run pep8
let g:pep8_map='<leader>8'

" ,v brings up my .vimrc
" ,V reloads it -- making all changes active (have to save first)
map <leader>vi :sp ~/.vimrc<CR><C-W>_
map <silent> <leader>VI :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" open/close the quickfix window
nmap <leader>co :copen<CR>
nmap <leader>cc :cclose<CR>

" for when we forget to use sudo to open/edit a file
cmap w!! w !sudo tee % >/dev/null

" Open NerdTree in a buffer on the left of the screen
let NERDTreeShowBookmarks = 1
let NERDChristmasTree = 1
let NERDTreeWinPos = "left"
map <leader>n :NERDTreeToggle<CR>

" Load the Gundo window
map <leader>g :GundoToggle<CR>

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
set number                    " Display line numbers
set numberwidth=1             " using only 1 column (and 1 space) while possible
set background=dark           " We are using dark background in vim
set title                     " show title in console title bar
set wildmenu                  " Menu completion in command mode on <Tab>
set wildmode=full             " <Tab> cycles between all matching choices.
set wrap                      " wrap tells Vim to word wrap visually

" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc

" Auto change the directory to the current file I'm working on
"autocmd BufEnter * lcd %:p:h

""" Insert completion
" don't select first item, follow typing in autocomplete
" set completeopt=menuone,longest,preview
" set pumheight=6             " Keep a small completion window

" show a line at column 79
if exists("&colorcolumn")
    set colorcolumn=79
endif

""" Moving Around/Editing
set cursorline              " have a line indicate the cursor location
set ruler                   " show the cursor position all the time
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=3             " Keep 3 context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set showmatch               " Briefly jump to a paren once it's balanced
set matchtime=2             " (for only .2 seconds).
set nowrap                  " don't wrap text
set linebreak               " don't wrap textin the middle of a word
set autoindent              " always set autoindenting on
set tabstop=4               " <tab> inserts 4 spaces
set shiftwidth=4            " but an indent level is 2 spaces wide.
set softtabstop=4           " <BS> over an autoindent deletes both spaces.
set expandtab               " Use spaces, not tabs, for autoindent/tab key.
set shiftround              " rounds indent to a multiple of shiftwidth
set matchpairs+=<:>         " show matching <> (html mainly) as well
set foldmethod=indent       " allow us to fold on indents
set foldlevel=99             " don't use fold by default

" close preview window automatically when we move around
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

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
"set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>
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


""" Spellcheck
set spell spelllang=en_us

" ==========================================================
" Python
" ==========================================================

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
" let g:SuperTabDefaultCompletionType = "context" 

" ==========================================================
" GVIM configuration
" ==========================================================
if has("gui_running")           " gvim
    set lines=65 columns=237    " Maximize
    set guioptions-=m           " Switch off menubar
    set guioptions-=T           " Switch off toolbar
endif

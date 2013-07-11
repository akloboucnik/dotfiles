set nocompatible               " be iMproved
filetype off                   " required!

syntax on
set number
set guifont=Menlo\ Regular:h12

" use system clipboard on Mac
" doesn't work with system vim
" (brew macvim)
set clipboard=unnamed
set ruler                 " Always show info along bottom.
set autoindent            " auto-indent
set tabstop=4             " tab spacing
set softtabstop=4         " unify
set shiftwidth=4          " indent/outdent by 4 columns
set shiftround            " always indent/outdent to the nearest tabstop
set expandtab             " use spaces instead of tabs
set smarttab              " use tabs at the start of a line, spaces elsewhere
set nowrap                " don't wrap text
set hls                   " highlight search
set noswapfile            " no backups, we have git
set autoread              " reload files
set nofoldenable          " no folding at all

" search
set ignorecase
set smartcase

" highlight current line
set cul

" status line (github.com/voy/dotfiles)
set ruler
set laststatus=2

set statusline=%(%m\ %)%f%(\ %y%)%(\ [%{&fileencoding}]%)\ %{fugitive#statusline()}%=[%3b,%4(0x%B%)]\ %3c\ %4l\ /%5L\ %4P
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set showcmd
set mouse=a

set t_Co=256

" remove trailing whitespace before save
autocmd BufWritePre * :%s/\s\+$//e

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'nono/vim-handlebars'
Bundle 'plasticboy/vim-markdown'
Bundle 'kien/rainbow_parentheses.vim'
" Bundle 'Lokaltog/vim-easymotion'
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" Bundle 'tpope/vim-rails.git'
" vim-scripts repos
" Bundle 'L9'
Bundle 'JavaScript-syntax'
" Bundle 'FuzzyFinder'
Bundle 'Syntastic'
Bundle 'gitignore'
" non github repos
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'guns/vim-clojure-static'
Bundle 'mileszs/ack.vim'
" ...

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

" theme and background
set background=light
" github256 is manually in .vim/colors - not Vundle managed
" take from here: https://bitbucket.org/wwortiz/dotfiles/raw/219eabfde57ef8912047bfb4b830f6a81e7a6cdd/.vim/colors/github256.vim
colorscheme github256

" have to use Terminal.app profile from here:
" https://github.com/sorin-ionescu/solarized/tree/692b152ed669cd0435d5233515fe6d17d67fe7a7/osx-terminal.app-colors-solarized/xterm-256color
" to work with bigger contrast
" FIXME this is the precise setup, DO NOT CHANGE ANYTHING OR IT WILL BREAK!
" solarized options
"let g:solarized_termcolors = 256
" let g:solarized_visibility = "high"
" let g:solarized_contrast = "high"

" Copy path to clipboard
" Convert slashes to backslashes for Windows.
if has('win32')
  nmap ,cs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
  nmap ,cl :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

  " This will copy the path in 8.3 short format, for DOS and Windows 9x
  nmap ,c8 :let @*=substitute(expand("%:p:8"), "/", "\\", "g")<CR>
else
  nmap ,cs :let @*=expand("%")<CR>
  "nmap ,cl :let @*=expand("%:p")<CR>
  nmap ,cl :let @*=substitute(expand("%:p"), getcwd()."/", "", "g")<CR>
endif

" Clojure
au BufRead,BufNewFile *.clj set filetype=clojure
au Syntax clojure RainbowParenthesesActivate
au Syntax clojure RainbowParenthesesLoadRound

" Ack
let g:ackprg = 'ag --nogroup --nocolor --column'

" FIXME: doesn't work now
let g:clj_highlight_builtins=1      " Highlight Clojure's builtins
let g:clj_paren_rainbow=1           " Rainbow parentheses'!

" Line numbering magic:
"   - if Vim loses focus I'm not gonna move -> absolute
"   - I don't move in insert mode -> absolute
" possibly replace with jeffkreeftmeijer/vim-numbertoggle
:au FocusLost * :set number
:au FocusGained * :set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber


au BufRead,BufNewFile *.hbs set filetype=handlebars
au BufRead,BufNewFile *.md,*.mdown set filetype=markdown

set nocompatible               " be iMproved
filetype off                   " required!

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

" visualize leading tab and trailing whitespace
set list lcs=tab\:\'\ ,trail:·

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
Bundle 'kien/ctrlp.vim'
" Bundle 'Lokaltog/vim-easymotion'
" Bundle 'tpope/vim-rails.git'
Bundle 'guns/vim-clojure-static'
Bundle 'tpope/vim-fireplace'
Bundle 'mileszs/ack.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'leafgarland/typescript-vim'
Bundle 'bling/vim-airline'
Bundle 'jeffkreeftmeijer/vim-numbertoggle'
Bundle 'kchmck/vim-coffee-script'
Bundle 'digitaltoad/vim-jade'
" vim-scripts repos
" Bundle 'L9'
" remove for not - not able to unmap \bb and so on - clashes with CtrlP
" Bundle 'bufkill.vim'
Bundle 'JavaScript-syntax'
Bundle 'Syntastic'
" non github repos

syntax enable
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
set background=dark
colorscheme solarized

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

" Handlebars
au BufRead,BufNewFile *.hbs set filetype=handlebars

" Markdown syntax
au BufRead,BufNewFile *.md,*.mdown set filetype=markdown

" CtrlP
" ignore all vcs meta data, gdc dist dirs and node_modules of node project
let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn|node_modules|dist|distribution|target)$'
nnoremap <leader>t :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>m :CtrlPMRUFiles<CR>

" Setup Airline
let g:airline_powerline_fonts = 1

"" Setup syntastic
" Better :sign interface symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
" use only jshint for javascript checks
let g:syntastic_javascript_checkers = ['jshint']

" do not fold markdown sections
let g:vim_markdown_folding_disabled = 1

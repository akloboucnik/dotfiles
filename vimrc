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

set statusline=%(%m\ %)pathshorten(%f)%(\ %y%)%(\ [%{&fileencoding}]%)\ %{fugitive#statusline()}%=[%3b,%4(0x%B%)]\ %3c\ %4l\ /%5L\ %4P
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

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'

" My Plugins here:
" original repos on github
Plugin 'tpope/vim-fugitive'
Plugin 'plasticboy/vim-markdown'
Plugin 'kien/ctrlp.vim'
Plugin 'j5shi/ctrlp_bdelete.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bling/vim-airline'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
Plugin 'tomtom/tcomment_vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'fatih/vim-go'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'StanAngeloff/php.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'metakirby5/codi.vim'
" vim-scripts repos
" Plugin 'L9'
" remove for not - not able to unmap \bb and so on - clashes with CtrlP
" Plugin 'bufkill.vim'
Plugin 'Syntastic'
" non github repos

call vundle#end()             " required!
filetype plugin indent on     " required!
syntax enable
"
" Brief help
" :PluginList          - list configured bundles
" :PluginInstall(!)    - install(update) bundles
" :PluginSearch(!) foo - search(or refresh cache first) for foo
" :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin command are not allowed..

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

" Markdown syntax
au BufRead,BufNewFile *.md,*.mdown set filetype=markdown

" Make
autocmd filetype make setlocal noexpandtab

" Commit msgs
autocmd Filetype gitcommit setlocal spell textwidth=72

" CtrlP
" ignore all vcs meta data, gdc dist dirs and node_modules of node project
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
nnoremap <leader>t :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>m :CtrlPMRUFiles<CR>

call ctrlp_bdelete#init()

" Setup Airline
let g:airline_powerline_fonts = 1
let g:airline_section_c = '%<%{pathshorten(substitute(expand("%:p"), getcwd()."/", "", "g"))}%m%#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'

"" Setup syntastic
" Better :sign interface symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
" use only jshint for javascript checks
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_check_on_open = 1

if !exists("*s:find_jshintrc")
    function s:find_jshintrc(dir)
        let l:found = globpath(a:dir, '.jshintrc')
        if filereadable(l:found)
            return l:found
        endif

        let l:parent = fnamemodify(a:dir, ':h')
        if l:parent != a:dir
            return s:find_jshintrc(l:parent)
        endif

        return "~/.jshintrc"
    endfunction
endif

if !exists("*UpdateJsHintConf")
    function UpdateJsHintConf()
        let l:dir = expand('%:p:h')
        let l:jshintrc = s:find_jshintrc(l:dir)
        let g:syntastic_javascript_jshint_args = l:jshintrc
    endfunction
endif

" call update only if ft=javascript
autocmd FileType javascript :autocmd BufEnter * call UpdateJsHintConf()

" do not fold markdown sections
let g:vim_markdown_folding_disabled = 1

"  Parentheses colours using Solarized
let g:rbpt_colorpairs = [
  \ [ '13', '#6c71c4'],
  \ [ '5',  '#d33682'],
  \ [ '1',  '#dc322f'],
  \ [ '9',  '#cb4b16'],
  \ [ '3',  '#b58900'],
  \ [ '2',  '#859900'],
  \ [ '6',  '#2aa198'],
  \ [ '4',  '#268bd2'],
  \ ]

" Clear search highlight
nnoremap <silent> _ :nohl<CR>

" JSX in JS
"let g:jsx_ext_required = 0
"

let g:ctrlp_buffer_func = { 'enter': 'CtrlPMappings' }

function! CtrlPMappings()
  nnoremap <buffer> <silent> <C-@> :call <sid>DeleteBuffer()<cr>
endfunction

function! s:DeleteBuffer()
  let path = fnamemodify(getline('.')[2:], ':p')
  let bufn = matchstr(path, '\v\d+\ze\*No Name')
  exec "bd" bufn ==# "" ? path : bufn
  exec "norm \<F5>"
endfunction

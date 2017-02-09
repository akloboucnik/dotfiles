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
set statusline+=%*

set showcmd
set mouse=a

set t_Co=256

" visualize leading tab and trailing whitespace
set list lcs=tab\:\·\ ,trail:·

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
Plugin 'kchmck/vim-coffee-script'
Plugin 'tomtom/tcomment_vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'StanAngeloff/php.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'w0rp/ale'
Plugin 'hdima/python-syntax'
Plugin 'davidhalter/jedi-vim'
Plugin 'albfan/ag.vim'
" vim-scripts repos
Plugin 'auto-pairs-gentle'
" Plugin 'L9'
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
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
\ }
nnoremap <leader>t :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>m :CtrlPMRUFiles<CR>

call ctrlp_bdelete#init()

" Setup Airline
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }
let g:airline_theme='solarized'
let g:airline_section_c = '%<%{pathshorten(substitute(expand("%:p"), getcwd()."/", "", "g"))}%m%#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0

"" Setup ale
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '!'
let g:ale_echo_msg_error_str = '✗'
let g:ale_echo_msg_warning_str = '!'
let g:ale_echo_msg_format = '[%linter%] %s'

" UtilSnips setup
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

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

let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'
let g:EditorConfig_core_mode = 'external_command'

let g:ctrlp_buffer_func = { 'enter': 'CtrlPMappings' }

hi SpecialKey ctermbg=8 ctermfg=10

function! CtrlPMappings()
  nnoremap <buffer> <silent> <C-@> :call <sid>DeleteBuffer()<cr>
endfunction

function! s:DeleteBuffer()
  let path = fnamemodify(getline('.')[2:], ':p')
  let bufn = matchstr(path, '\v\d+\ze\*No Name')
  exec "bd" bufn ==# "" ? path : bufn
  exec "norm \<F5>"
endfunction

let python_hightlight_all = 1

augroup python_files
    autocmd FileType python setlocal noexpandtab
    autocmd FileType python set tabstop=4
    autocmd FileType python set shiftwidth=4
    autocmd FileType python set list lcs=tab\:\·\ ,trail:·
augroup END

augroup coffee_script
    autocmd FileType coffee setlocal noexpandtab
    autocmd FileType coffee set tabstop=4
    autocmd FileType coffee set shiftwidth=4
    autocmd FileType coffee set list lcs=tab\:\·\ ,trail:·
augroup END

augroup yaml_files
    autocmd FileType yaml set tabstop=2
    autocmd FileType yaml set shiftwidth=2
augroup END

au BufRead,BufNewFile Dockerfile* setfiletype dockerfile

" tab switching
nnoremap H gT
nnoremap L gt

nnoremap <leader>w :bd <CR>
nnoremap <leader>W :bufdo bd <CR>

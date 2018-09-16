set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-syntastic/syntastic'

Plugin 'prettier/vim-prettier', {
  \ 'do': ['yarn install'],
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }

" Theming
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'joshdick/onedark.vim'

" Utilities
Plugin 'jiangmiao/auto-pairs'
Plugin 'godlygeek/tabular'

" Syntax Highlighting
Plugin 'mxw/vim-jsx'
Plugin 'dart-lang/dart-vim-plugin'
Plugin 'tikhomirov/vim-glsl'
Plugin 'pangloss/vim-javascript'
Plugin 'plasticboy/vim-markdown'

call vundle#end()
filetype plugin indent on

syntax on

set number
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set autoindent

let g:airline_powerline_fonts = 1
let g:airline_theme = 'onedark'
colorscheme onedark

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 25

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'yarn lint'

let g:vim_markdown_folding_disabled = 1


" when running at every change you may want to disable quickfix
let g:prettier#quickfix_enabled = 0

let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.css,*.scss,*.less PrettierAsync



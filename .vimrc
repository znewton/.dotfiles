set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'w0rp/ale'

" Theming
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'joshdick/onedark.vim'

" Utilities
Plugin 'jiangmiao/auto-pairs'
Plugin 'godlygeek/tabular'
if has('nvim')
  Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plugin 'Shougo/deoplete.nvim'
  Plugin 'roxma/nvim-yarp'
  Plugin 'roxma/vim-hug-neovim-rpc'
endif
Plugin 'airblade/vim-gitgutter'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'dhruvasagar/vim-table-mode'

" 'Intellisense'
Plugin 'ternjs/tern_for_vim', { 'do': 'yarn install' }
Plugin 'carlitux/deoplete-ternjs'

" Syntax
Plugin 'mxw/vim-jsx'
Plugin 'dart-lang/dart-vim-plugin'
Plugin 'tikhomirov/vim-glsl'
Plugin 'pangloss/vim-javascript'
Plugin 'plasticboy/vim-markdown'
Plugin 'avakhov/vim-yaml'

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

let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 25

let g:ale_fixers = { 'javascript': ['prettier', 'eslint']}
let g:ale_fix_on_save = 1
let g:ale_pattern_options = {
      \  '.*CS336/projects/.*': { 'ale_fixers': [], 'ale_linters': [] },
      \}

let g:vim_markdown_folding_disabled = 1

" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#ternjs#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx'
                \]

let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='

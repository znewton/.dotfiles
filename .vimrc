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
Plugin 'netsgnut/arctheme.vim'

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
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'

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
Plugin 'leafgarland/typescript-vim'
Plugin 'peitalin/vim-jsx-typescript'

call vundle#end()
filetype plugin indent on

syntax on

set number
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set autoindent
set cursorline

let g:airline_powerline_fonts = 1
let g:airline_theme = 'iceberg'
colorscheme iceberg

let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 20
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_list_hide= '.*\.swp$,\~$,\.orig$'

nnoremap _ :Vexplore<CR>
nnoremap <C-Q> :q<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let g:ale_fixers = { 'javascript': ['prettier', 'eslint'], 'typescript': ['prettier', 'tslint']}
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

augroup Syntax
  au!
  autocmd BufNewFile,BufRead .prettierrc set syntax=json
  autocmd BufNewFile,BufRead .eslintrc set syntax=json
  autocmd BufNewFile,BufRead .babelrc set syntax=json
augroup END


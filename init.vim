call plug#begin('~/.local/share/nvim/plugged')

Plug 'w0rp/ale'

" Theming
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'
Plug 'netsgnut/arctheme.vim'

" Utilities
Plug 'jiangmiao/auto-pairs'
Plug 'godlygeek/tabular'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'airblade/vim-gitgutter'
Plug 'dhruvasagar/vim-table-mode'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Syntax
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'avakhov/vim-yaml'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'jparise/vim-graphql'

" 'Intellisense'
Plug 'ternjs/tern_for_vim'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm i -g tern' }
Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }

call plug#end()

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

let g:ale_fixers = { 
	\  'javascript': ['prettier', 'eslint'],
	\  'typescript': ['prettier', 'tslint']
	\}
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
		\ 'js',
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
  autocmd BufNewFile,BufRead *.prisma set syntax=graphql
augroup END


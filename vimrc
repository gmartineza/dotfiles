" Sets
filetype plugin on
set backspace=indent,eol,start
set path+=**
set wildmenu

set number
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set noswapfile

set nohlsearch
set incsearch
set ignorecase
set smartcase

set termguicolors
set guioptions=
colorscheme desert
set scrolloff=1
syntax enable
set nowrap

let g:netrw_banner=0
let g:netrw_liststyle=3

" Remaps
let mapleader = " "

nnoremap <leader>e :E<CR>
nnoremap <leader>. :e $MYVIMRC<CR>

noremap <leader>p "*P
noremap <leader>y "*y
nnoremap <leader>Y "*Y
noremap <leader>d "_d

nnoremap n nzz
nnoremap N Nzz
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

inoremap <C-c> <Esc>
nnoremap Q <Nop>

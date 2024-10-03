set number
set relativenumber
set noswapfile
set ignorecase
set smartcase
set tabstop=4
set shiftwidth=4
set expandtab

let mapleader = " "
inoremap <c-c> <Esc>
nnoremap <c-s> :w<cr>
nnoremap <leader>, :e $MYVIMRC<cr>
xnoremap <leader>p "_dP
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y
nnoremap <leader>d "_d
vnoremap <leader>d "_d

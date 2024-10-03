set number
set relativenumber
set noswapfile
set ignorecase
set smartcase
set tabstop=4
set shiftwidth=4
set expandtab
set undofile

let mapleader = " "
inoremap <c-c> <Esc>
nnoremap <c-c> :nohl<cr>
nnoremap <c-s> :w<cr>
nnoremap <leader>, :e $MYVIMRC<cr>
xnoremap <leader>p "_dP
nnoremap <leader>Y "+Y
noremap <leader>y "+y
noremap <leader>d "_d

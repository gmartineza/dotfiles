set relativenumber
set noswapfile
set ignorecase
set smartcase
set incsearch
set tabstop=4
set shiftwidth=4
set expandtab
set belloff=all
set backspace=2
set clipboard=unnamedplus
" Default register is "
" Yank register is 0
" Check registers with `:reg`

let mapleader = " "
inoremap <c-c> <Esc>
nnoremap <c-c> <silent> :nohl<cr>
nnoremap <c-s> :w<cr>
nnoremap <leader>, :e $MYVIMRC<cr>
xnoremap <leader>p "_dP
noremap <leader>d "_d

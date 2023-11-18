let mapleader = " "

" Sets
"filetype plugin on
"set backspace=indent,eol,start
set path+=**
"set wildmenu

set number
set relativenumber
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set noswapfile
set nohlsearch
set ignorecase
set smartcase
"set incsearch
set termguicolors
set guioptions=
set scrolloff=1
"syntax enable
set nowrap

colorscheme desert
let g:netrw_banner=0

" Remaps

nnoremap <LEADER>e :Lex<CR>j
nnoremap <LEADER>, :e $MYVIMRC<CR>
nnoremap <LEADER>f :find 
nnoremap <LEADER>g :vimgrep // **<LEFT><LEFT><LEFT><LEFT>
nnoremap <LEADER>n :cnext<CR>
nnoremap <LEADER>N :cprevious<CR>
nnoremap <LEADER>t :terminal<CR>
inoremap <C-c> <Esc>
nnoremap <C-s> :w<CR>
noremap <leader>p "*P
noremap <leader>y "*y
nnoremap <leader>Y "*Y
noremap <leader>d "_d
nnoremap n nzz
nnoremap N Nzz
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

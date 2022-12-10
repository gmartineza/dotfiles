local nnoremap = require("gmartineza.keymap").nnoremap
local inoremap = require("gmartineza.keymap").inoremap
local vnoremap = require("gmartineza.keymap").vnoremap
local nmap = require("gmartineza.keymap").nmap
local xnoremap = require("gmartineza.keymap").xnoremap

-- Heressy
inoremap("<C-c>", "<ESC>")

-- Explorer
nnoremap("<leader>e", "<cmd>Ex<CR>jj")
nnoremap("<leader>c", "<cmd>Ex ~/.config/nvim<CR>jj")

-- Buffer remaps
nnoremap('<leader>bD','<cmd>%bdelete|edit #|normal `"<CR>')
nnoremap("<leader>bi","<cmd>bn<CR>")
nnoremap("<leader>bo","<cmd>bp<CR>")
nnoremap("<leader>bl",":ls<CR>:b ")

nnoremap("<C-h>","<C-w>h")
nnoremap("<C-j>","<C-w>j")
nnoremap("<C-k>","<C-w>k")
nnoremap("<C-l>","<C-w>l")

-- Find files
nnoremap("<C-f>",":find ")

-- Run files
nnoremap("<leader>r.", "<cmd>w|so %<CR>")

-- Prime's greatest remaps ever(disambiguation of yank and clipboard)
--nnoremap("<leader>p", "\"_p")
vnoremap("<leader>p", '"0P')
xnoremap("<leader>p", '"0P')
--nnoremap("<leader>P", "\"_P")

nnoremap("<leader>y", "\"+y")
vnoremap("<leader>y", "\"+y")
nmap("<leader>Y", "\"+Y")

nnoremap("<leader>d", "\"_d")
vnoremap("<leader>d", "\"_d")

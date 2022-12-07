local nnoremap = require("gmartineza.keymap").nnoremap
local inoremap = require("gmartineza.keymap").inoremap
local vnoremap = require("gmartineza.keymap").vnoremap
local nmap = require("gmartineza.keymap").nmap
local xnoremap = require("gmartineza.keymap").xnoremap

nnoremap("<leader>e", "<cmd>Le<CR>")

--heresy
inoremap("<C-c>", "<ESC>")

nnoremap('<leader>bD','<cmd>%bdelete|edit #|normal `"<CR>')
nnoremap("<leader>i","<cmd>bn<CR>")
nnoremap("<leader>o","<cmd>bp<CR>")
nnoremap("<leader>l","<cmd>ls<CR>")

nnoremap("<C-h>","<C-w>h")
nnoremap("<C-j>","<C-w>j")
nnoremap("<C-k>","<C-w>k")
nnoremap("<C-l>","<C-w>l")

nnoremap("<leader>f",":find ")

nnoremap("<leader>r+",":w|!g++ %<CR>:term ./a.out")
nnoremap("<leader>r.", ":w|so %")

-- Prime's greatest remaps ever
nnoremap("<leader>p", "\"*p")
vnoremap("<leader>p", "\"*p")
nnoremap("<leader>P", "\"*P")
vnoremap("<leader>P", "\"*P")

nnoremap("<leader>y", "\"+y")
vnoremap("<leader>y", "\"+y")
nmap("<leader>Y", "\"+Y")

nnoremap("<leader>d", "\"_d")
vnoremap("<leader>d", "\"_d")

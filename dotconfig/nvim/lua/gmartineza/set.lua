vim.opt.termguicolors = true
vim.cmd[[
au ColorScheme * hi Normal ctermbg=none guibg=none
au ColorScheme myspecialcolors hi Normal ctermbg=none guibg=none
colorscheme gruvbox
]]

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.scrolloff = 8

vim.opt.swapfile = false
vim.opt.updatetime = 50

vim.g.mapleader = " "

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25
--vim.cmd[[let g:netrw_list_hide = '^\.\.\=/\=$,']]

vim.cmd("set path+=**")

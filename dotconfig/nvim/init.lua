---------------------------------------------------------------------- Leader key
vim.g.mapleader = ' '
---------------------------------------------------------------------- Lazy plugins bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
---------------------------------------------------------------------- Sets
vim.cmd.set("path+=**")

vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.swapfile = false

vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.splitright = true

vim.o.completeopt = "menu,menuone"

vim.o.signcolumn = "no"

vim.cmd("colorscheme evening")
---------------------------------------------------------------------- Netrw
vim.g.netrw_banner = 0
---------------------------------------------------------------------- Remaps
vim.keymap.set('n', "<leader>e", ":Ex<cr>j", { silent = true })
vim.keymap.set('n', "<leader>,", ":e $MYVIMRC<cr>", { silent = true })
vim.keymap.set('n', "<C-f>", ":find ")
vim.keymap.set('n', "<leader>g", ":vimgrep // **<left><left><left><left>")
vim.keymap.set('n', "<leader>n", vim.cmd.cnext, { silent = true })
vim.keymap.set('n', "<leader>N", vim.cmd.cprevious, { silent = true })
vim.keymap.set('n', "<leader>t", ":15split term://bash<cr>", { silent = true })
vim.keymap.set('i', "<c-c>", "<esc>")
vim.keymap.set('n', "<c-s>", ":w<CR>", { silent = true })
vim.keymap.set('x', "<leader>p", '"_dP')
vim.keymap.set('n', "<leader>p", '"*p')
vim.keymap.set('n', "<leader>P", '"*P')
vim.keymap.set('', "<leader>y", '"+y')
vim.keymap.set('n', "<leader>Y", '"+Y')
vim.keymap.set('n', "<leader>d", '"_d')
vim.keymap.set('n', 'n', "nzz")
vim.keymap.set('n', 'N', "Nzz")
vim.keymap.set('i', "<C-Space>", "<C-x><C-o>")

--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Setting options ]]
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.undofile = true

-- [[ Keymaps ]]
vim.keymap.set("n", "<leader>,", "<cmd>e $MYVIMRC<CR>")

vim.keymap.set("i", "<C-c>",     "<Esc>")
vim.keymap.set("n", "<C-c>",     "<cmd>nohl<CR>")
vim.keymap.set("n", "<Esc>",     "<cmd>nohl<CR>")

vim.keymap.set({"n", "v"},       "<leader>d", [["_d]])
vim.keymap.set({"n", "v"},       "<leader>y", [["+y]])
vim.keymap.set("n",              "<leader>p", [["+p]])

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require("lazy").setup("plugins")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

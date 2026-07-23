--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Setting options ]]
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.wrap = false

-- [[ Keymaps ]]
vim.keymap.set("n", "<leader>,", "<cmd>e $MYVIMRC<CR>")

vim.keymap.set("i", "<C-c>",     "<Esc>")
vim.keymap.set("n", "<C-c>",     "<cmd>nohl<CR>")
vim.keymap.set("n", "<Esc>",     "<cmd>nohl<CR>")

vim.keymap.set("n", "<leader>t", "<cmd>tabnew | term<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>t",     "<cmd>:tabnew | term<CR>")


vim.keymap.set({"n", "v"},       "<leader>d", [["_d]])
vim.keymap.set("n",              "<leader>p", [["_dp]])
vim.keymap.set("n",              "<leader>P", [["_dP]])
vim.keymap.set({"n", "v"},       "<leader>y", [["+y]])
vim.keymap.set("n",              "<leader>c", [[<cmd>let @+ = expand("%")<CR>]])

-- [[ pwsh > cmd ]]
if vim.fn.has("win32") == 1 then
  vim.o.shell = "pwsh.exe"
end

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

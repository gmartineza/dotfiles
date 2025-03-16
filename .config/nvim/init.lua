--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Setting options ]]
vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.opt.hlsearch = false

-- [[ Basic Keymaps ]]
-- Heressy
vim.keymap.set("n", "<C-s>", "<cmd>write<CR>")
vim.keymap.set("i", "<C-c>", "<Esc>")

-- prime's stuff
vim.keymap.set({"n", "v"},  "<leader>y", [["+y]])
vim.keymap.set("n",         "<leader>Y", [["+Y]])
vim.keymap.set({"n", "v"},  "<leader>d", [["_d]])
vim.keymap.set("x",         "<leader>p", [["_dP]])

vim.keymap.set("n", "<leader>e", "<cmd>Explore<CR>")
vim.keymap.set("n", "<leader>,", "<cmd>e $MYVIMRC<CR>")

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
require("lazy").setup({
  { "tpope/vim-surround" },

  {
    "easymotion/vim-easymotion",
    keys = {
      { "s", "<Plug>(easymotion-s2)", mode = "n", noremap = true, silent = true },
    },
    lazy = true,
    event = "VeryLazy",
  },

  {
    "arcticicestudio/nord-vim",
    cond = (function() return not vim.g.vscode end),
    priority = 1000,
    config = function ()
      vim.cmd.colorscheme('nord')
    end
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

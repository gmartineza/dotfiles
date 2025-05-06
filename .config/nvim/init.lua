--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- VSCode-Neovim stuff --
-- conditional sets: --
-- if vim.g.vscode then
--     -- VSCode extension
-- else
--     -- ordinary Neovim
-- end
-- conditional plugins --
-- cond = vim.g.vscode

-- [[ Setting options ]]
if not vim.g.vscode then
  vim.opt.number = true
  -- vim.opt.breakindent = true
  vim.opt.cursorline = true
  vim.opt.scrolloff = 5
  vim.opt.wrap = false
  vim.keymap.set("n", "<leader>e", "<cmd>Explore<CR>")
  vim.keymap.set("n", "<leader>,", "<cmd>e $MYVIMRC<CR>")
end

vim.opt.undofile = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.path:append('**')

-- [[ Basic Keymaps ]]
-- Heressy
vim.keymap.set("n", "<C-s>", "<cmd>write<CR>")
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-c>", "<cmd>nohl<CR>")

-- prime's stuff
vim.keymap.set({"n", "v"},  "<leader>y", [["+y]])
vim.keymap.set("n",         "<leader>Y", [["+Y]])
vim.keymap.set("n",         "<leader>p", [["+p]])
vim.keymap.set("n",         "<leader>P", [["+P]])
vim.keymap.set({"n", "v"},  "<leader>d", [["_d]])
vim.keymap.set("v",         "<leader>p", [["_dP]])


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
  -- { "tpope/vim-repeat" },
  { 
    "Darazaki/indent-o-matic",
    cond = not vim.g.vscode
  },
  {
    import = "terminal-plugins",
    enable = true,
    cond = not vim.g.vscode
  }
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

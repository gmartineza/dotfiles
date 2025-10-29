--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--[[ VSCode keybindings.json

[
    {
        "key": "ctrl+tab",
        "command": "workbench.action.nextEditor",
        "when": "!activeEditorGroupEmpty"
    },
    {
        "key": "ctrl+shift+tab",
        "command": "workbench.action.previousEditor",
        "when": "!activeEditorGroupEmpty"
    },
    {
        "key": "ctrl+tab",
        "command": "-workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup",
        "when": "!activeEditorGroupEmpty"
    },
    {
        "key": "ctrl+shift+tab",
        "command": "-workbench.action.quickOpenLeastRecentlyUsedEditorInGroup",
        "when": "!activeEditorGroupEmpty"
    },
    {
        "key": "alt+t",
        "command": "workbench.action.terminal.toggleTerminal"
    },
    {
        "key": "alt+b",
        "command": "workbench.action.toggleSidebarVisibility"
    },
]

Also add to "terminal.integrated.commandsToSkipShell": "workbench.action.toggleSidebarVisibility" and "workbench.action.terminal.toggleTerminal"

--]]
-- [[ Setting options ]]
vim.opt.number = true
vim.opt.scrolloff = 5
vim.opt.wrap = false
vim.opt.tabstop=4
vim.opt.shiftwidth=4
-- vim.opt.clipboard = { "unnamed", "unnamedplus" }
vim.opt.path:append('**')
vim.opt.undofile = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.swapfile = false

-- [[ Keymaps ]]
vim.keymap.set("n", "<leader>e", "<cmd>Ex<CR>")
vim.keymap.set("n", "<leader>,", "<cmd>e $MYVIMRC<CR>")
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc><cmd>w<CR>")
vim.keymap.set("n", "<C-c>", "<cmd>nohl<CR>")
vim.keymap.set("n", "<Esc>", "<cmd>nohl<CR>")
-- vim.keymap.set({"n", "v"},  "<leader>d", [["_d]])
-- vim.keymap.set("v",         "<leader>p", [["_dP]])
-- -- prime's stuff
vim.keymap.set({"n", "v"},  "<leader>y", [["+y]])
vim.keymap.set("n",         "<leader>Y", [["+Y]])
vim.keymap.set("n",         "<leader>p", [["+p]])
vim.keymap.set("n",         "<leader>P", [["+P]])
vim.keymap.set({"n", "v"},  "<leader>d", [["_d]])
-- vim.keymap.set("v",         "<leader>p", [["_dP]])

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
  {
    "tpope/vim-surround",
    dependencies = "tpope/vim-repeat",
  },
  {
    "windwp/nvim-autopairs",
    enabled = true,
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  {
    "ggandor/leap.nvim",
    dependencies = {
      "tpope/vim-repeat"
    },
    config = function()
      vim.keymap.set({'n', 'x', 'o'}, 'x', '<Plug>(leap-forward)')
      vim.keymap.set({'n', 'x', 'o'}, 'X', '<Plug>(leap-backward)')
      vim.keymap.set({'n', 'x', 'o'}, 'gx', '<Plug>(leap-from-window)')
    end
  }
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

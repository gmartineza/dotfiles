-- [[ Guidelines ]]
-- Layout:   one plugin per file in lua/plugins/<name>.lua, returning a lazy.nvim spec. Core options and
--           global keymaps live in this file. Commit lazy-lock.json together with the plugin change.
-- Keymaps:  every <leader> mapping gets a `desc` (which-key renders it). New <leader> prefixes need a
--           group label in lua/plugins/which-key.lua. Check which-key for a free key before binding.
-- Loading:  lazy-load via `keys`, `cmd` or `event`. Use `lazy = false` only when the plugin must run at
--           startup, and say why in a comment.
-- Scope:    prefer native Neovim, then an installed plugin, before adding a dependency. Check that a
--           plugin repo is alive.
-- Windows:  the shell is pwsh and shellcmdflag is not set for it. Call external tools in list form
--           (vim.fn.system({ "rg", "--files" })), never as a shell string.
-- Verify:   `nvim --headless +qa` must exit clean, and try the changed keys for real before committing.
-- Commits:  Conventional Commits with a scope, e.g. feat(nvim): ...

--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

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
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.list = false
vim.opt.signcolumn = "yes"

-- [[ Keymaps ]]
vim.keymap.set("n", "<leader>,", "<cmd>tabnew $MYVIMRC | tcd %:p:h<CR>", { desc = "Open nvim config in new tab" })
vim.keymap.set("n", " ", "<Nop>")

vim.keymap.set("i", "<C-c>",     "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("n", "<C-c>",     "<cmd>nohl<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<Esc>",     "<cmd>nohl<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<C-s>",     "<cmd>write<CR>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>",     "<Esc><cmd>write<CR>", { desc = "Save file" })

vim.keymap.set("n", "<leader>tt", "<cmd>tabnew | term<CR>", { desc = "Terminal in new tab" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set({"n", "v"},       "<leader>d", [["_d]],  { desc = "Delete without yanking" })
vim.keymap.set({     "v"},       "<leader>p", [["_dp]], { desc = "Replace with paste (after)" })
vim.keymap.set({"n", "v"},       "<leader>P", [["_dP]], { desc = "Replace with paste (before)" })
vim.keymap.set({"n", "v"},       "<leader>y", [["+y]],  { desc = "Yank to system clipboard" })
vim.keymap.set("n",              "<leader>c", [[<cmd>let @+ = expand("%")<CR>]], { desc = "Copy file path" })
vim.keymap.set("n",              "<leader>n", "<cmd>cnext<CR>zz", { desc = "Quickfix: next" })
vim.keymap.set("n",              "<leader>p", "<cmd>cprev<CR>zz", { desc = "Quickfix: previous" })
vim.keymap.set("n",              "<leader>N", "<cmd>clast<CR>zz", { desc = "Quickfix: Next" })
vim.keymap.set("n",              "<leader>P", "<cmd>cfirst<CR>zz", { desc = "Quickfix: Previous" })

-- [[ Autocommands ]]
   vim.api.nvim_create_autocmd("FileType", {
    pattern = { "json", "jsonc" },
    callback = function()
      vim.bo.commentstring = "//%s"
    end,
  })

-- [[ `lazy.nvim` plugin manager ]]
require("config.lazy")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

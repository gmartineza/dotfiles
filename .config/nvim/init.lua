-- Opts
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Key mappings
vim.keymap.set("n", "<C-s>", "<cmd>write<CR>")
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<leader>g", ":vim /")
vim.keymap.set("n", "<leader>e", ":Explore<CR>")
vim.keymap.set("n", "<leader>,", ":e $MYVIMRC<CR>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-c>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("v", "<leader>p", "\"_dP")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

require("lazy").setup({
    {
        "kylechui/nvim-surround",
        version = "*", -- For stability
        opts = {},
        -- event = "VeryLazy",
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
        lazy = false,
    },
    {
        "ggandor/leap.nvim",
        -- Dependencies = "tpope/vim-repeat",
        config = function()
            local leap = require('leap')
            vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
            -- vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)')
            vim.keymap.set('n', 'S',  '<Plug>(leap-backward)')
            vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
            leap.opts.case_sensitive = true
        end,
    }
})

if not vim.g.vscode then
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true
    vim.opt.number = true

    -- vim.keymap.set("n", "<leader>g", ":vim /")
end

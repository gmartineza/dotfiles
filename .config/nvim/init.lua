-- Opts
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
-- vim.opt.wrap = false
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 4
vim.opt.breakindent = true
-- vim.opt.conceallevel = 2

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Key mappings
vim.keymap.set("n", "<C-s>", "<cmd>write<CR>")
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<leader>e", "<cmd>Ex<CR>")
vim.keymap.set("n", "<leader>,", ":e $MYVIMRC<CR>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-c>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("v", "<leader>p", "\"_dP")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
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
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
    },

    {
        "calind/selenized.nvim",
        config = function()
            vim.cmd.colorscheme "selenized"
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function () 
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                highlight = { enable = true },
                indent = { enable = true },  
            })
        end
    },

    {
        "tadmccorkle/markdown.nvim",
        ft = "markdown", -- or 'event = "VeryLazy"'
        config = function()
                require("markdown").setup({
                on_attach = function(bufnr)
                    local map = vim.keymap.set
                    local opts = { buffer = bufnr }
                    map({ 'n', 'i' }, '<M-o>', '<Cmd>MDListItemBelow<CR>', opts)
                    map({ 'n', 'i' }, '<M-O>', '<Cmd>MDListItemAbove<CR>', opts)
                    map({ 'n', 'i' }, '<M-l><M-r>', '<Cmd>MDResetListNumbering<CR>', opts)
                    map('n', '<M-l><M-t>', '<Cmd>MDTaskToggle<CR>', opts)
                    map('x', '<M-l><M-t>', ':MDTaskToggle<CR>', opts)
                end,
            })
    end
    },
    { import = 'obsidian' }
})

if not vim.g.vscode then
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true
    vim.opt.number = true

    -- vim.keymap.set("n", "<leader>g", ":vim /")
end

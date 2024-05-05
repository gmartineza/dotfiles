vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>g", ":vim /")
vim.keymap.set("n", "<leader>e", ":E<CR>")
vim.keymap.set("n", "<leader>.", ":e $MYVIMRC<CR>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("v", "<leader>p", "\"_dP")

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
        -- dependencies = "tpope/vim-repeat",
        config = function()
            -- require('leap').opts.case_sensitive = true
            vim.keymap.set({'n', 'x'},        's', '<Plug>(leap)')
            vim.keymap.set('n',        'S', '<Plug>(leap-from-window)')
        end,
    },
    {
        "Darazaki/indent-o-matic",
        opts = {}
    }
})

if not vim.g.vscode then
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true
    vim.opt.number = true
    vim.opt.relativenumber = true

    -- vim.keymap.set("n", "<leader>g", ":vim /")
end

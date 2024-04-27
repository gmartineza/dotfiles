vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>g", ":vim /")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

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
        event = "VeryLazy",
        opts = {}
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
        lazy = false,
    },
    {
        "ggandor/leap.nvim",
        dependencies = "tpope/vim-repeat",
        config = function()
            require('leap').opts.case_sensitive = true
            vim.keymap.set('n',        's', '<Plug>(leap)')
            vim.keymap.set('n',        'S', '<Plug>(leap-from-window)')
            vim.keymap.set({'x', 'o'}, 's', '<Plug>(leap-forward)')
            vim.keymap.set({'x', 'o'}, 'S', '<Plug>(leap-backward)')
        end,
    },
    {"VonHeikemen/lsp-zero.nvim",
    cond = not vim.g.vscode,
    branch = "v3.x",
    dependencies = 
    {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        {
            "L3MON4D3/LuaSnip",
        }
    }
}
})
if not vim.g.vscode then
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true
    vim.opt.number = true
    vim.opt.relativenumber = true

    local lsp_zero = require('lsp-zero')

    require('cmp').setup({
        sources = {
            { name = 'nvim_lsp' },
            { name = 'buffer' }
        },
    })


    lsp_zero.on_attach(function(client, bufnr)
        -- :help lsp-zero-keybindings
        lsp_zero.default_keymaps({buffer = bufnr})
    end)

    -- Replace the language servers listed here
	-- with the ones you have installed
    lsp_zero.setup_servers({"jedi_language_server"})
    -- :h lspconfig-all
end

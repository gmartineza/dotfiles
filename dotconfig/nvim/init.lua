vim.g.mapleader=' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
	},
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'L3MON4D3/LuaSnip'},
    'numToStr/Comment.nvim',
    -- {'theprimeagen/harpoon',
    --     dependencies = {'nvim-lua/plenary.nvim'}
    -- },
    {
        'ellisonleao/gruvbox.nvim',
        priority = 1000,
        -- lazy = false,
        config = function()
            vim.cmd.colorscheme 'gruvbox'
        end,
    },
})

vim.defer_fn(function ()
require'nvim-treesitter.configs'.setup {
	auto_install = true,
	highlight = { enable = true},
	indent = { enable = true}
    }
end, 0)

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    lsp_zero.default_setup,
  },
})

-- require('lspconfig').lua_ls.setup{settings={Lua={diagnostics={globals={'vim'}}}}}
--
-- local mark = require("harpoon.mark")
-- local ui = require("harpoon.ui")
--
-- vim.keymap.set("n", "<leader>h", mark.add_file)
-- vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
-- vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
-- vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
-- vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
-- vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

require('Comment').setup()

vim.cmd.set('path+=**')
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.swapfile = false
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.termguicolors = true
vim.o.scrolloff = 1
vim.o.wrap = false

vim.g.netrw_banner = 0
-- vim.g.netrw_list_hide = '^\.\.\=/\=$'
-- vim.g.netrw_hide = 1
-- vim.g.netrw_browse_split = 4
-- vim.g.netrw_altv = 1
-- vim.g.netrw_liststyle = 4
-- vim.g.netrw_winsize = 20
-- vim.g.netrw_liststyle = 3

vim.keymap.set('n', '<leader>e', ':Lex<cr>j', {silent = true})--            Open explorer (Netrw)   
vim.keymap.set('n', '<leader>,', ':e $MYVIMRC<cr>', {silent = true})--      Edit config
vim.keymap.set('n', '<leader>f', ':find ')--                                Find files in cwd
vim.keymap.set('n', '<leader>g',':vimgrep // **<left><left><left><left>')-- Find word in files in cwd recursively
vim.keymap.set('n', '<leader>n', vim.cmd.cnext, {silent = true})--          Find next grep match
vim.keymap.set('n', '<leader>N', vim.cmd.cprevious, {silent = true})--      Find previous grep match
vim.keymap.set('i', '<c-c>', '<esc>')--                                     Ctrl+c > Esc > Ctrl+[
vim.keymap.set('n', '<c-s>', vim.cmd.write, {silent = true})--              Ctrl+s > :w

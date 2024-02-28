-- [[ Setting options ]]
vim.opt.number = true
vim.opt.relativenumber = true

-- vim.opt.clipboard = 'unnamedplus'

-- vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'no'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
-- vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 2

vim.cmd.set 'path+=**'
vim.cmd.colorscheme 'slate'
vim.opt.hlsearch = false
vim.o.wrap = false

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- vim: ts=2 sts=2 sw=2 et

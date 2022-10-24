vim.cmd('colorscheme gruvbox')
vim.cmd('set background=dark')

-- Keymaps --

local keymap = vim.api.nvim_set_keymap
vim.g.mapleader = " "
-- Buffer delete all except current
keymap("n", "<leader>bD",  "<cmd>%bd<CR><C-o><cmd>bd#<CR>", { noremap = true })
-- Visual mode sanitiy remaps
keymap("v", "<",           "<gv",                           { noremap = true, silent = true })
keymap("v", ">",           ">gv",                           { noremap = true, silent = true })
keymap("v", "p",           '"_dP',                          { noremap = true, silent = true })
-- Run code
keymap("n", "<leader>rp",  "<cmd>w|term py %<CR>",          { noremap = true })
keymap("n", "<leader>rc", ":w|!gcc %<CR>:term ./a.out",    { noremap = true })
keymap("n", "<leader>r+", ":w|!g++ %<CR>:term ./a.out",    { noremap = true })
keymap("n", "<leader>r.", ":w|so %",    { noremap = true })
-- Snippets with no plugins (1st line below is for Unix, 2nd is for Windows)
keymap("i", "\\cpp", "<cmd>-1read ~/.config/nvim/snippets/cppSkeleton.txt<CR><ESC>3j", { noremap = true, silent = true })
--keymap("i", "\\cpp", "<cmd>-1read ~\\AppData\\Local\\nvim\\snippets\\cppSkeleton.txt<CR><ESC>3j", { noremap = true, silent = true })

-- Options --

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard:append('unnamedplus')
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.writebackup = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 3
vim.opt.termguicolors = true
vim.opt.hidden = true
vim.opt.syntax = 'enable'
vim.opt.mouse = 'a'
-- Netrw
vim.cmd([[
let g:netrw_banner = 0
let g:netrw_list_hide = '^\.\.\=/\=$,.exe,@,.lnk,.ini,ntuser,.db'
]])
-- Transparency
vim.cmd([[
highlight! Normal ctermbg=NONE guibg=NONE
highlight! EndOfBuffer ctermbg=NONE guibg=NONE
]])
-- Set `:term foo` and `!foo` to use PowerShell
--vim.cmd([[
--let &shell = has('win32') ? 'powershell' : 'pwsh'
--let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
--let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
--let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
--set shellquote= shellxquote=
--]])

-- Plugins --

require "plugins"

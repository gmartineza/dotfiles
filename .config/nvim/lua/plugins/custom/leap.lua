local enabled = true
if not enabled then return end

vim.pack.add {
  'https://github.com/tpope/vim-repeat',
  'https://codeberg.org/andyg/leap.nvim', -- GitHub repo is emptied, moved to Codeberg
}

require('leap').opts.vim_opts['ignorecase'] = false
require('leap').opts.vim_opts['smartcase'] = true
vim.keymap.set({ 'n', 'x', 'o' }, 'x', '<Plug>(leap-forward)')
vim.keymap.set({ 'n', 'x', 'o' }, 'X', '<Plug>(leap-backward)')
vim.keymap.set({ 'n', 'x', 'o' }, 'gx', '<Plug>(leap-from-window)')

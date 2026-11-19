local enabled = true
if not enabled then return end

vim.pack.add { 'https://github.com/tpope/vim-fugitive' }

vim.keymap.set('n', '<leader>gg', '<cmd>Git<CR>', { desc = 'Git Status (Fugitive)' })
vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<CR>', { desc = 'Git Diff View' })
vim.keymap.set('n', '<leader>gbl', ':Git blame<CR>', { desc = 'Git Diff View' })

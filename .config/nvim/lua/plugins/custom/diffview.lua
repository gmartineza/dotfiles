local enabled = true
if not enabled then return end

vim.pack.add { 'https://github.com/sindrets/diffview.nvim' }

require('plugins.custom.util').keys {
  { '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', desc = 'File history' },
  { '<leader>gH', '<cmd>DiffviewFileHistory<CR>',   desc = 'Repo history' },
  { '<leader>gh', ":'<,'>DiffviewFileHistory<CR>",  mode = 'v', desc = 'Line range history' },
  { '<leader>gq', '<cmd>DiffviewClose<CR>',         desc = 'Close diffview' },
}

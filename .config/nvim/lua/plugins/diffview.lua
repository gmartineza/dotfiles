return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose' },
  keys = {
    { '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', desc = 'File history' },
    { '<leader>gH', '<cmd>DiffviewFileHistory<CR>',   desc = 'Repo history' },
    { '<leader>gh', ":'<,'>DiffviewFileHistory<CR>",  mode = 'v', desc = 'Line range history' },
    { '<leader>gq', '<cmd>DiffviewClose<CR>',         desc = 'Close diffview' },
  },
}

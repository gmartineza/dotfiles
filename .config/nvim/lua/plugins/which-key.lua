return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    triggers = { { '<leader>', mode = { 'n', 'v' } } },
    spec = {
      { '<leader>f', group = 'find' },
      { '<leader>g', group = 'git' },
      { '<leader>h', group = 'hunk' },
      { '<leader>a', group = 'claude' },
    },
  },
}

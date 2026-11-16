return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    triggers = { { '<leader>', mode = { 'n', 'v' } }, { 'g', mode = 'n' } },
    spec = {
      { '<leader>f', group = 'find' },
      { '<leader>g', group = 'git' },
      { '<leader>h', group = 'hunk' },
      { '<leader>a', group = 'claude' },
      { '<leader>b', group = 'buffers/history' },
      { 'gr', group = 'lsp' },
    },
  },
}

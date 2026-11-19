local enabled = false
if not enabled then return end

vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/GustavEikaas/easy-dotnet.nvim',
}
require('easy-dotnet').setup {
  picker = 'fzf-lua',
  background_scanning = false,
  test_runner = { auto_start_testrunner = false },
}

require('plugins.custom.util').keys {
  { '<leader>ds', '<cmd>Dotnet solution select<CR>', desc = 'Dotnet: select solution' },
}

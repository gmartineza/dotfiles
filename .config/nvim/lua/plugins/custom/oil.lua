local enabled = true
if not enabled then return end

vim.pack.add { 'https://github.com/stevearc/oil.nvim' }
require('oil').setup {
  default_file_explorer = false,
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = false,
  },
}

require('plugins.custom.util').keys {
  { '<leader>o', '<cmd>Oil<CR>', desc = 'Open Oil' },
}

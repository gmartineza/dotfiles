local enabled = true
if not enabled then return end

vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  { src = 'https://github.com/mikavilpas/yazi.nvim', version = vim.version.range '*' }, -- latest stable
}

-- mark netrw as loaded so it's not loaded at all.
-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
vim.g.loaded_netrwPlugin = 1

require('yazi').setup {
  open_for_directories = false,
  keymaps = {
    show_help = '<f1>',
  },
}

require('plugins.custom.util').keys {
  { '<leader>ef', '<cmd>Yazi<cr>', mode = { 'n', 'v' }, desc = 'Open yazi at the current file' },
  { '<leader>ed', '<cmd>Yazi cwd<cr>', desc = "Open the file manager in nvim's working directory" },
  { '<leader>e.', '<cmd>Yazi toggle<cr>', desc = 'Resume the last yazi session' },
}

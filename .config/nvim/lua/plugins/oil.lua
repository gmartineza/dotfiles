return {
  'stevearc/oil.nvim',
  cmd = 'Oil',
  keys = {
    { '<leader>o', '<cmd>Oil<CR>', desc = 'Open Oil' },
  },
  opts = {
    default_file_explorer = false,
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = false,
    },
  },
}

return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = false,
    view_options = {
    -- Show files and directories that start with "."
    show_hidden = false,
    }
  },
  lazy = false,
  keys = {
    { '<leader>e', '<cmd>Oil<CR>', desc = 'Open Oil' },
  },
}

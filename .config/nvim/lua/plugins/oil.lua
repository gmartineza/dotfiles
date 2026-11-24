return {
  'stevearc/oil.nvim',
  lazy = false,
  keys = {
    { '<leader>o', '<cmd>Oil<CR>', desc = 'Open Oil' },
  },
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
  },
}

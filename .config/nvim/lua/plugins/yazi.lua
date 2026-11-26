return {
  'mikavilpas/yazi.nvim',
  version = '*', -- latest stable
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = 'Yazi',
  keys = {
    { '<leader>e.', '<cmd>Yazi<cr>', mode = { 'n', 'v' }, desc = 'Open yazi at the current file' },
    { '<leader>ec', '<cmd>Yazi cwd<cr>', desc = "Open the file manager in nvim's working directory" },
    { '<leader>er', '<cmd>Yazi toggle<cr>', desc = 'Resume the last yazi session' },
  },
  init = function()
    -- mark netrw as loaded so it's not loaded at all.
    -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
    vim.g.loaded_netrwPlugin = 1
  end,
  opts = {
    open_for_directories = false,
    keymaps = {
      show_help = '<f1>',
    },
  },
}

return {
  'nvim-tree/nvim-tree.lua',
  -- netrw must be off before the plugin loads
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  lazy = false,
  opts = {},
  keys = {
    { '<leader>e', '<cmd>NvimTreeToggle<CR>',   desc = 'Toggle file tree' },
    { '<leader>E', '<cmd>NvimTreeFindFile<CR>', desc = 'Reveal file in tree' },
  },
}

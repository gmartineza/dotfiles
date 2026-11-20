-- Useful plugin to show you pending keybinds.
-- No `triggers` override: the default <auto> triggers cover every mapped prefix (<leader>, g, ], ys, ...)
return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    -- Delay between pressing a key and opening which-key (milliseconds)
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },
    -- Document existing key chains
    spec = {
      { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
      { '<leader>g', group = '[G]it' },
      { '<leader>e', group = 'Yazi', mode = { 'n', 'v' } },
      { 'gr', group = 'LSP Actions', mode = { 'n' } },
    },
  },
}

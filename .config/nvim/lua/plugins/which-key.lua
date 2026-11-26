-- Useful plugin to show you pending keybinds.
return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    -- Delay between pressing a key and opening which-key (milliseconds)
    delay = 0,
    -- Only <leader> and gr (LSP) open the popup (no g, ], ys, ...)
    triggers = { { '<leader>', mode = { 'n', 'v' } }, { 'gr', mode = 'n' } },
    -- Hide <leader>y / <leader>p so they run without a popup
    filter = function(mapping)
      local lhs = vim.keycode(mapping.lhs)
      for _, k in ipairs { 'y', 'p' } do
        if vim.startswith(lhs, vim.keycode('<leader>' .. k)) then return false end
      end
      return true
    end,
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

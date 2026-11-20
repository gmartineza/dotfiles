return {
  'saghen/blink.cmp',
  version = '1.*',
  -- not InsertEnter: blink registers its LSP capabilities on load, which must happen before servers attach
  event = 'VimEnter',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1) and 'make install_jsregexp' or nil,
      opts = {},
    },
  },
  opts = {
    keymap = {
      -- 'default' (recommended) for mappings similar to built-in completions
      --   <c-y> to accept ([y]es) the completion.
      -- See `:help blink-cmp-config-keymap` for defining your own keymap
      preset = 'default',
    },
    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      nerd_font_variant = 'mono',
    },
    sources = {
      default = { 'lsp', 'path', 'snippets' },
    },
    snippets = { preset = 'luasnip' },
    -- See `:help blink-cmp-config-fuzzy` for more information
    fuzzy = { implementation = 'lua' },
    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
  },
}

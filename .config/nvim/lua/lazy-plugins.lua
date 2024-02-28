require('lazy').setup {

  'tpope/vim-sleuth',
  -- Use `opts = {}` to force a plugin to be loaded.
  -- This is equivalent to:
  --   require('Comment').setup({})

  { 'numToStr/Comment.nvim', opts = {} },

  -- modular approach: using `require 'path/name'` will
  -- include a plugin definition from file lua/path/name.lua

  require 'kickstart/plugins/telescope',

  require 'kickstart/plugins/lspconfig',

  require 'kickstart/plugins/cmp',

  require 'kickstart/plugins/treesitter',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information see: :help lazy.nvim-lazy.nvim-structuring-your-plugins
  -- { import = 'custom.plugins' },
}

-- vim: ts=2 sts=2 sw=2 et

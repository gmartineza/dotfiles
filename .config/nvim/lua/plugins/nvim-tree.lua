return {
  'nvim-tree/nvim-tree.lua',
  -- netrw must be off before the plugin loads
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  lazy = false,
  enabled = false,
  opts = {
    git = { show_on_dirs = true, show_on_open_dirs = true, timeout = 2000 },
    filters = { dotfiles = false, git_ignored = false, custom = {} },
    renderer = { icons = { glyphs = {
      default = "",
      symlink = "",
      bookmark = "󰆤",
      modified = "●",
      hidden = "󰜌",
    git = {
      unstaged = "M",
      staged = "S",
      unmerged = "U",
      renamed = "R",
      untracked = "N",
      deleted = "D",
      ignored = "I",
    },
    } } },
  },
  config = function(_, opts)
    local api = require('nvim-tree.api')
    local scope = require('scope')
    opts.renderer.decorators = {
      'Git', 'Open', 'Hidden', 'Modified', 'Bookmark', 'Diagnostics', 'Copied',
      require('scope-decorator'), 'Cut',
    }
    opts.on_attach = function(bufnr)
      api.config.mappings.default_on_attach(bufnr)
      vim.keymap.set('n', 'gs', function()
        local node = api.tree.get_node_under_cursor()
        if node then scope.toggle(node.absolute_path) end
      end, { buffer = bufnr, desc = 'Toggle search scope' })
    end
    scope.on_change(function() if api.tree.is_visible() then api.tree.reload() end end)
    require('nvim-tree').setup(opts)
  end,
keys = {
  { '<leader>e', '<cmd>NvimTreeToggle<CR>',   desc = 'Toggle file tree' },
  { '<leader>E', '<cmd>NvimTreeFindFile<CR>', desc = 'Reveal file in tree' },
},
}

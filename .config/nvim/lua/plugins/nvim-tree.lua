return {
  'nvim-tree/nvim-tree.lua',
  -- netrw must be off before the plugin loads
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  lazy = false,
  opts = {
    git = { show_on_dirs = true, show_on_open_dirs = true },
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
keys = {
  { '<leader>e', '<cmd>NvimTreeToggle<CR>',   desc = 'Toggle file tree' },
  { '<leader>E', '<cmd>NvimTreeFindFile<CR>', desc = 'Reveal file in tree' },
},
}

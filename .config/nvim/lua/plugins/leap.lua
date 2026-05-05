return {
  {
    "ggandor/leap.nvim",
    enabled = true,
    dependencies = {
      "tpope/vim-repeat"
    },
    config = function()
      require('leap').opts.vim_opts['ignorecase'] = false
      require('leap').opts.vim_opts['smartcase'] = true
      vim.keymap.set({'n', 'x', 'o'}, 'x', '<Plug>(leap-forward)')
      vim.keymap.set({'n', 'x', 'o'}, 'X', '<Plug>(leap-backward)')
      vim.keymap.set({'n', 'x', 'o'}, 'gx', '<Plug>(leap-from-window)')
    end
  },
}

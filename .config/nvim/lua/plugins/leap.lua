useleap = true
return
{
  {
    "folke/flash.nvim",
    enabled = not useleap,
    event = "VeryLazy",
    ---@type Flash.Config
    ---@diagnostic disable-next-line
    opts = { jump = { autojump = true, },
    modes = { char = { enabled = false, }, },
  },
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, noremap = true },
  },
},
{
  -- "ggandor/flit.nvim",
  "ggandor/leap.nvim",
  enabled = useleap,
  dependencies = {
    "tpope/vim-repeat"
  },
  config = function()
    vim.keymap.set({'n', 'x', 'o'}, 'x', '<Plug>(leap-forward)')
    vim.keymap.set({'n', 'x', 'o'}, 'X', '<Plug>(leap-backward)')
    vim.keymap.set({'n', 'x', 'o'}, 'gx', '<Plug>(leap-backward)')
  end
}
}

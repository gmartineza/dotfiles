return {
  {
    "kawre/leetcode.nvim",
    cond = not vim.g.vscode,
    enabled = false,
    dependencies = {
      {
        'nvim-mini/mini.pick',
        version = '*',
        config = function()
          require('mini.pick').setup()
        end
      },
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
    },
  }
}

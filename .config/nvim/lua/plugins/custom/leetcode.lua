local enabled = false
if not enabled or vim.g.vscode then return end

vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/nvim-mini/mini.nvim', -- provides mini.pick
  'https://github.com/kawre/leetcode.nvim',
}
require('mini.pick').setup()
require('leetcode').setup {}

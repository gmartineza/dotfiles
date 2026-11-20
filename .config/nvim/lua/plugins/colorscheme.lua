return {
  'gbprod/nord.nvim',
  lazy = false, -- main colorscheme, must be ready at startup
  priority = 1000,
  config = function() vim.cmd.colorscheme 'nord' end,
}

local enabled = true
if not enabled then return end

-- plugin itself is added in init.lua (SECTION 9); this only adds c_sharp
require('nvim-treesitter').install { 'c_sharp' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'cs',
  callback = function(args) pcall(vim.treesitter.start, args.buf) end,
})

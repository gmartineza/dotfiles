local enabled = true
if not enabled then return end

vim.pack.add { 'https://github.com/folke/which-key.nvim' }
require('which-key').setup {
  triggers = { { '<leader>', mode = { 'n', 'v' } }, { 'g', mode = 'n' } },
  spec = {
    { '<leader>f', group = 'find' },
    { '<leader>g', group = 'git' },
    { '<leader>h', group = 'hunk' },
    { '<leader>a', group = 'claude' },
    { '<leader>b', group = 'buffers/history' },
    { 'gr', group = 'lsp' },
  },
}

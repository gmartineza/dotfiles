local enabled = true
if not enabled then return end

-- ^4 for stability; drop `version` to follow `main`
vim.pack.add { { src = 'https://github.com/kylechui/nvim-surround', version = vim.version.range '^4.0.0' } }
require('nvim-surround').setup {}

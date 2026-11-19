local enabled = false
if not enabled then return end

vim.pack.add { { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '1.*' } }
require('blink.cmp').setup {
  fuzzy = { implementation = 'prefer_rust_with_warning' },
  sources = {
    default = { 'lsp', 'easy-dotnet', 'path', 'buffer' },
    providers = {
      ['easy-dotnet'] = {
        name = 'easy-dotnet',
        enabled = true,
        module = 'easy-dotnet.completion.blink',
        score_offset = 10000,
        async = true,
      },
    },
  },
}

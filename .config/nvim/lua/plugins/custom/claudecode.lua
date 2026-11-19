local enabled = true
if not enabled then return end

vim.pack.add { 'https://github.com/coder/claudecode.nvim' }
-- server (and ~/.claude/ide lock file) must exist before claude's /ide runs
-- claude runs in its own zellij pane (see zellij/layouts/dev.kdl); connect with /ide
require('claudecode').setup { terminal = { provider = 'none' } }

require('plugins.custom.util').keys {
  { '<leader>ab', '<cmd>ClaudeCodeAdd %<CR>',       desc = 'Add current buffer' },
  { '<leader>as', '<cmd>ClaudeCodeSend<CR>',        mode = 'v', desc = 'Send selection to Claude' },
  { '<leader>ay', '<cmd>ClaudeCodeDiffAccept<CR>',  desc = 'Accept diff' },
  { '<leader>an', '<cmd>ClaudeCodeDiffDeny<CR>',    desc = 'Deny diff' },
}

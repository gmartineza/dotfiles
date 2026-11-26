return {
  url = 'https://codeberg.org/andyg/leap.nvim', -- GitHub repo is emptied, moved to Codeberg
  dependencies = { 'tpope/vim-repeat' },
  keys = {
    { 'x', '<Plug>(leap)', mode = { 'n', 'x', 'o' }, desc = 'Leap to where [x] marks the spot' },
    -- { 'x', '<Plug>(leap-forward)', mode = { 'n', 'x', 'o' }, desc = 'Leap forward' },
    { 'X', '<Plug>(leap-backward)', mode = { 'n', 'x', 'o' }, desc = 'Leap back to where [X] marks the spot' },
    { 'gx', '<Plug>(leap-from-window)', mode = { 'n', 'x', 'o' }, desc = 'Leap to other pane where [g][x] marks the spot' },
  },
  config = function()
    require('leap').opts.vim_opts['ignorecase'] = false
    require('leap').opts.vim_opts['smartcase'] = true
  end,
}

return {
  'kylechui/nvim-surround',
  version = '^4.0.0', -- ^4 for stability; drop `version` to follow `main`
  -- the plugin's default keymaps; pressing one loads it
  keys = {
    { '<C-g>s', mode = 'i', desc = 'Add a surrounding pair around the cursor (insert mode)' },
    { '<C-g>S', mode = 'i', desc = 'Add a surrounding pair around the cursor, on new lines (insert mode)' },
    { 'ys', desc = 'Add a surrounding pair around a motion (normal mode)' },
    { 'yss', desc = 'Add a surrounding pair around the current line (normal mode)' },
    { 'yS', desc = 'Add a surrounding pair around a motion, on new lines (normal mode)' },
    { 'ySS', desc = 'Add a surrounding pair around the current line, on new lines (normal mode)' },
    { 'ds', desc = 'Delete a surrounding pair' },
    { 'cs', desc = 'Change a surrounding pair' },
    { 'cS', desc = 'Change a surrounding pair, putting replacements on new lines' },
    { 'S', mode = 'x', desc = 'Add a surrounding pair around a visual selection' },
    { 'gS', mode = 'x', desc = 'Add a surrounding pair around a visual selection, on new lines' },
  },
  opts = {},
}

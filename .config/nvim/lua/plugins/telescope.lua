-- Fuzzy Finder (files, lsp, etc). See `:help telescope` and `:help telescope.setup()`
-- LSP pickers (grr, gri, grd, gO, gW, grt) are mapped in lsp.lua
local function builtin(name, opts)
  return function() require('telescope.builtin')[name](opts and opts() or nil) end
end

return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  event = 'LspAttach', -- so ui-select covers code action menus (gra) from the first one

  keys = {
    { '<leader>sh', builtin 'help_tags', desc = '[S]earch [H]elp' },
    { '<leader>sk', builtin 'keymaps', desc = '[S]earch [K]eymaps' },
    { '<leader>sf', builtin 'find_files', desc = '[S]earch [F]iles' },
    { '<leader>ss', builtin 'builtin', desc = '[S]earch [S]elect Telescope' },
    { '<leader>sw', builtin 'grep_string', mode = { 'n', 'v' }, desc = '[S]earch current [W]ord' },
    { '<leader>sg', builtin 'live_grep', desc = '[S]earch by [G]rep' },
    { '<leader>sd', builtin 'diagnostics', desc = '[S]earch [D]iagnostics' },
    { '<leader>sr', builtin 'resume', desc = '[S]earch [R]esume' },
    { '<leader>s.', builtin 'oldfiles', desc = '[S]earch Recent Files ("." for repeat)' },
    { '<leader>sc', builtin 'commands', desc = '[S]earch [C]ommands' },
    { '<leader><leader>', builtin 'buffers', desc = '[ ] Find existing buffers' },
    -- Override default behavior and theme when searching
    {
      '<leader>/',
      builtin('current_buffer_fuzzy_find', function() return require('telescope.themes').get_dropdown { winblend = 10, previewer = false } end),
      desc = '[/] Fuzzily search in current buffer',
    },
    {
      '<leader>s/',
      builtin('live_grep', function() return { grep_open_files = true, prompt_title = 'Live Grep in Open Files' } end),
      desc = '[S]earch [/] in Open Files',
    },
    -- Shortcut for searching your Neovim configuration files
    { '<leader>sn', builtin('find_files', function() return { cwd = vim.fn.stdpath 'config', follow = true } end), desc = '[S]earch [N]eovim files' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function() return vim.fn.executable 'make' == 1 end,
    },
    'nvim-telescope/telescope-ui-select.nvim',
  },
  config = function()
    require('telescope').setup {
      extensions = {
        ['ui-select'] = { require('telescope.themes').get_dropdown() },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
  end,
}

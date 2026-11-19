-- Explicit order: later modules rely on plugins added by earlier ones
-- (e.g. easy-dotnet needs fzf-lua). Each module guards itself with an `enabled` flag.
local modules = {
  'colorscheme',
  'indent',
  'surround',
  'autopairs',
  'blink-cmp',
  'which-key',
  'gitsigns',
  'fugitive',
  'diffview',
  'treesitter',
  'fzf-lua',
  'oil',
  'nvim-tree',
  'yazi',
  'leap',
  'claudecode',
  'easy-dotnet',
  'leetcode',
}

for _, name in ipairs(modules) do
  local ok, err = pcall(require, 'plugins.custom.' .. name)
  if not ok then vim.notify(('plugins.custom.%s failed:\n%s'):format(name, err), vim.log.levels.ERROR) end
end

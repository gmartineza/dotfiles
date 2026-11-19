local catppuccin = false
local nord = false
local gruvbox = true

if catppuccin then
  vim.pack.add { { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' } }
  vim.cmd.colorscheme 'catppuccin-macchiato'
end

if nord then
  vim.pack.add { { src = 'https://github.com/gbprod/nord.nvim', name = 'nord' } }
  vim.cmd.colorscheme 'nord'
end

if gruvbox then
  vim.pack.add { { src = 'https://github.com/ellisonleao/gruvbox.nvim', name = 'gruvbox' } }
  vim.cmd.colorscheme 'gruvbox'
end

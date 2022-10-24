return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'gruvbox-community/gruvbox'
    use 'jiangmiao/auto-pairs'
    use 'mhinz/vim-startify'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
end)

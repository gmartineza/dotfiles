return {
    {
        "catppuccin/nvim",
        enabled = false,
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin-macchiato")
        end,
    },
    {
        "gbprod/nord.nvim",
        enabled = false,
        name = "nord",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("nord")
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        enabled = true,
        name = "gruvbox",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("gruvbox")
        end,
    }
}

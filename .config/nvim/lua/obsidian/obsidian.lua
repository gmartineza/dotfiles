return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/cmp-buffer",
        "hrsh7th/nvim-cmp"
    },
    opts = {
        dir = "~/Syncthing/notes",
        completion = {
            nvim_cmp = true,
            min_chars = 0,
        },
        ui = {
            enable = false
        }
    }
}

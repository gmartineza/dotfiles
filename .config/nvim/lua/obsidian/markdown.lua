return {
    "tadmccorkle/markdown.nvim",
    enabled = false,
    ft = "markdown", -- or 'event = "VeryLazy"'
    config = function()
        require("markdown").setup({
            on_attach = function(bufnr)
                local map = vim.keymap.set
                local opts = { buffer = bufnr }
                map({ 'n', 'i' }, '<M-o>', '<Cmd>MDListItemBelow<CR>', opts)
                map({ 'n', 'i' }, '<M-O>', '<Cmd>MDListItemAbove<CR>', opts)
                map({ 'n', 'i' }, '<M-l><M-r>', '<Cmd>MDResetListNumbering<CR>', opts)
                map('n', '<M-l><M-t>', '<Cmd>MDTaskToggle<CR>', opts)
                map('x', '<M-l><M-t>', ':MDTaskToggle<CR>', opts)
            end,
        })
    end
}

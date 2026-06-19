return {
    'tpope/vim-fugitive',
    enabled = true,
    config = function()
        vim.keymap.set('n', '<leader>gg', "<cmd>Git<cr>", { desc = "Git Status (Fugitive)" })
        vim.keymap.set('n', '<leader>gd', "<cmd>DiffviewOpen<cr>", { desc = "Git Diff View" })
    end
}

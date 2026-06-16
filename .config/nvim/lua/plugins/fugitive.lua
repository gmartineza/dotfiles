return { 
	'tpope/vim-fugitive',
	enable = true,
	config = function()
		vim.keymap.set('n', '<leader>gg', "<cmd>Git<CR>", { desc = "Git Status (Fugitive)" })
		vim.keymap.set('n', '<leader>gd', "<cmd>DiffviewOpen<CR>", { desc = "Git Diff View" })
	end
}

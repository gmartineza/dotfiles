return { 
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    config = function()
      vim.keymap.set("n", "<c-p>", "<cmd>FZF<CR>")
      vim.keymap.set("n", "<leader>s,", "<cmd>FZF ~/dotfiles/.config/nvim/<CR>")
      vim.keymap.set("n", "<leader>s.", "<cmd>FZF ~/dotfiles/.config/<CR>")
      vim.keymap.set("n", "<leader>sn", "<cmd>FZF ~/dotfiles/.config/<CR>")
      vim.keymap.set("n", "<leader>sh", "<cmd>FZF %:h<CR>")
    end
  }
}

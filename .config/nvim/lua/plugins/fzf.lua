return { 
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    config = function()
      vim.keymap.set("n", "<c-p>", "<cmd>FZF<CR>")
    end
  }
}

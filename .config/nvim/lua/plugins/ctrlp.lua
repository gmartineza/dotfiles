return {
  {
    "ctrlpvim/ctrlp.vim",
    config = function()
      vim.g.ctrlp_show_hidden = 1
      vim.keymap.set("n", "<leader>ff", "<cmd>Oil<CR>")
      vim.keymap.set("n", "<leader>f.", "<cmd>Oil<CR>")
    end,
  }
}

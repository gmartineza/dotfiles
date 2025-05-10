return {
  "junegunn/fzf",
  {
    "junegunn/fzf.vim",
    config = function ()
    vim.keymap.set("n", "<leader>ff", "<cmd>Files<CR>")
    vim.keymap.set("n", "<leader>f.", "<cmd>Files ~/.config/nvim/<CR>")
    end
  }
}

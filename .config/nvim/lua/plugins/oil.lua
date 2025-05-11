return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = false,
      buf_options = {
        bufhidden = "show"
      }
    },
    config = function()
      vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>")
    end,
    lazy = false,
  }
}

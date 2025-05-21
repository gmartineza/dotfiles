return {
  {
    'stevearc/oil.nvim',
    enabled = true,
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = false,
      buf_options = {
        bufhidden = "show"
      }
    },
    config = function()
      vim.keymap.set("n", "-", "<cmd>Oil<CR>")
    end,
    lazy = false,
  }
}

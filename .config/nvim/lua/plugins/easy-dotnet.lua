return {
  {
    "GustavEikaas/easy-dotnet.nvim",
    enabled = true,
    cmd = { "Dotnet" },
    dependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua" },
    keys = {
      { "<leader>ds", "<cmd>Dotnet solution select<CR>", desc = "Dotnet: select solution" },
    },
    config = function()
      require("easy-dotnet").setup({
        picker = "fzf-lua",
        background_scanning = false,
        test_runner = { auto_start_testrunner = false },
      })
    end
  }
}

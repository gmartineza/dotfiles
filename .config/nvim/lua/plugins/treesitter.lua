return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  -- main branch does not support lazy-loading
  lazy = false,
  config = function()
    require("nvim-treesitter").install({ "c_sharp" })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "cs",
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}

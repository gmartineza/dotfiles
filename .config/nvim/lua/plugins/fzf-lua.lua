return {
  {
    "ibhagwan/fzf-lua",
    enabled = true,
    keys = {
      { "<leader>ff", "<cmd>FzfLua files<CR>",      desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<CR>",  desc = "Live grep" },
      { "<leader>fb", "<cmd>FzfLua buffers<CR>",    desc = "Buffers" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<CR>",   desc = "Recent files" },
      { "<leader>fc", "<cmd>FzfLua grep_cword<CR>", desc = "Grep word under cursor" },
    },
    opts = {},
  },
}

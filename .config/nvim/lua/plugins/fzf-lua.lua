return {
  {
    "ibhagwan/fzf-lua",
    enabled = true,
    keys = {
      { "<leader>ff", "<cmd>FzfLua files<CR>",      desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<CR>",  desc = "Live grep" },
      { "<leader>fc", "<cmd>FzfLua grep_cword<CR>", desc = "Grep word under cursor" },
      { "<leader>f.", "<cmd>FzfLua resume<CR>", desc = "Resume previous Fzf-Lua search" },
    },
    opts = {},
  },
}

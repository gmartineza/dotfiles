return {
  {
    "ibhagwan/fzf-lua",
    enabled = true,
    keys = {
      { "<leader>ff", "<cmd>FzfLua files<CR>",      desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<CR>",  desc = "Live grep" },
      { "<leader>fc", "<cmd>FzfLua grep_cword<CR>", desc = "Grep word under cursor" },
      { "<leader>f.", "<cmd>FzfLua resume<CR>", desc = "Resume previous Fzf-Lua search" },
      { "<leader>fq", "<cmd>FzfLua lgrep_quickfix<CR>", desc = "Live grep quickfix files" },
      { "<leader>fd", function()
          local dirs = "fd --type d"
          if vim.fn.executable("fd") == 0 then
            -- fallback: rg can't list dirs, derive them from `rg --files` (respects .gitignore)
            local seen = {}
            dirs = {}
            for _, f in ipairs(vim.fn.systemlist("rg --files")) do
              local d = vim.fs.dirname(f)
              while d and d ~= "." and not seen[d] do
                seen[d] = true
                table.insert(dirs, d)
                d = vim.fs.dirname(d)
              end
            end
            table.sort(dirs)
          end
          require("fzf-lua").fzf_exec(dirs, {
            prompt = "Dirs> ",
            actions = { default = function(sel) require("fzf-lua").files({ cwd = sel[1] }) end },
          })
        end, desc = "Find dir, then files in it" },
    },
    opts = {},
  },
}

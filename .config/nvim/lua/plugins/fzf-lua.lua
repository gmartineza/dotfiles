local scope = require("scope")

-- all dirs under cwd. fallback: rg can't list dirs, derive them from `rg --files` (respects .gitignore)
local function dirs()
  if vim.fn.executable("fd") == 1 then return "fd --type d" end
  local seen, out = {}, {}
  for _, f in ipairs(vim.fn.systemlist({ "rg", "--files" })) do
    local d = vim.fs.dirname(f)
    while d and d ~= "." and not seen[d] do
      seen[d] = true
      table.insert(out, d)
      d = vim.fs.dirname(d)
    end
  end
  table.sort(out)
  return out
end

local function scoped(fn)
  return function()
    local list = scope.list()
    if #list == 0 then return vim.notify("Search scope is empty (<leader>fs, <leader>fa or gs in tree)") end
    fn(list)
  end
end

return {
  {
    "ibhagwan/fzf-lua",
    enabled = true,
    keys = {
      { "<leader>ff", "<cmd>FzfLua files<CR>",      desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<CR>",  desc = "Live grep" },
      { "<leader>fc", "<cmd>FzfLua grep_cword<CR>", desc = "Grep word under cursor" },
      { "<leader>f.", "<cmd>FzfLua resume<CR>", desc = "Resume previous Fzf-Lua search" },
      { "<leader>gbr", "<cmd>FzfLua git_branches<CR>", desc = "Switch git branch" },
      { "<leader>fq", "<cmd>FzfLua lgrep_quickfix<CR>", desc = "Live grep quickfix files" },
      { "<leader>fs", function()
          require("fzf-lua").fzf_exec(dirs(), {
            prompt = "Scope (Tab=multi)> ",
            fzf_opts = { ["--multi"] = true },
            actions = { default = function(sel) scope.set(sel); vim.notify("Scope: " .. table.concat(sel, ", ")) end },
          })
        end, desc = "Set search scope (dirs)" },
      { "<leader>fa", function() scope.add(vim.fn.expand("%:p:h")) end, desc = "Add buffer dir to scope" },
      { "<leader>fS", function() scope.clear() end, desc = "Clear search scope" },
      { "<leader>fF", scoped(function(list)
          local files = vim.fn.systemlist(vim.list_extend({ "rg", "--files", "--" }, list))
          require("fzf-lua").fzf_exec(files, { prompt = "Scoped files> ", actions = require("fzf-lua").defaults.actions.files })
        end), desc = "Find files in scope" },
      { "<leader>fG", scoped(function(list)
          require("fzf-lua").live_grep({ search_paths = list })
        end), desc = "Live grep in scope" },
      { "<leader>bb", "<cmd>FzfLua buffers<CR>",   desc = "Buffers" },
      { "<leader>bo", "<cmd>FzfLua oldfiles<CR>",  desc = "Recent files" },
      { "<leader>bj", "<cmd>FzfLua jumps<CR>",     desc = "Jumplist" },
      { "<leader>bm", "<cmd>FzfLua marks<CR>",     desc = "Marks" },
      { "<leader>bq", "<cmd>FzfLua quickfix<CR>",  desc = "Quickfix" },
      { "<leader>bl", "<cmd>FzfLua loclist<CR>",   desc = "Location list" },
      { "<leader>b/", "<cmd>FzfLua blines<CR>",    desc = "Lines in buffer" },
      { "<leader>gl", "<cmd>FzfLua git_commits<CR>",  desc = "Project commits" },
      { "<leader>gL", "<cmd>FzfLua git_bcommits<CR>", desc = "File commits" },
      { "<leader>gs", "<cmd>FzfLua git_status<CR>",   desc = "Git status picker" },
      { "<leader>gS", "<cmd>FzfLua git_stash<CR>",    desc = "Git stash" },
      { "<leader>fd", function()
          require("fzf-lua").fzf_exec(dirs(), {
            prompt = "Dirs> ",
            actions = { default = function(sel) require("fzf-lua").files({ cwd = sel[1] }) end },
          })
        end, desc = "Find dir, then files in it" },
    },
    opts = {},
  },
}

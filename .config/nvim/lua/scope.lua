-- Ad-hoc search scope: dirs/files that scoped find/grep (fzf-lua.lua) is limited to.
-- Shared with nvim-tree (toggle key + glyph) so there is one source of truth.
local M = {}

local paths = {}
local listeners = {}

local function norm(p)
  return (vim.fs.normalize(vim.fn.fnamemodify(p, ":p")):gsub("/$", ""))
end

local function changed()
  for _, f in ipairs(listeners) do pcall(f) end
end

function M.on_change(f) table.insert(listeners, f) end
function M.has(p) return vim.tbl_contains(paths, norm(p)) end
function M.list() return vim.deepcopy(paths) end

function M.add(p)
  p = norm(p)
  if not vim.tbl_contains(paths, p) then table.insert(paths, p) end
  changed()
end

function M.toggle(p)
  p = norm(p)
  local i = vim.fn.index(paths, p) + 1
  if i > 0 then table.remove(paths, i) else table.insert(paths, p) end
  changed()
end

function M.set(list)
  paths = vim.tbl_map(norm, list)
  changed()
end

function M.clear()
  paths = {}
  changed()
end

return M

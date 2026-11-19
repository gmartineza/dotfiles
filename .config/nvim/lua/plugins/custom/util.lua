local M = {}

--- Set keymaps from a lazy.nvim-style `keys` list: { lhs, rhs, mode = ..., desc = ... }
---@param list table[]
function M.keys(list)
  for _, k in ipairs(list) do
    vim.keymap.set(k.mode or 'n', k[1], k[2], { desc = k.desc })
  end
end

return M

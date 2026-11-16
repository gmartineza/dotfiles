-- nvim-tree decorator: glyph after names that are in the ad-hoc search scope (see scope.lua).
local scope = require("scope")

---@class (exact) ScopeDecorator: nvim_tree.api.Decorator
local ScopeDecorator = require("nvim-tree.api").Decorator:extend()

function ScopeDecorator:new()
  self.enabled = true
  self.highlight_range = "none"
  self.icon_placement = "after"
  self.icon = { str = "󰍉", hl = { "NvimTreeBookmark" } }
end

function ScopeDecorator:icons(node)
  if scope.has(node.absolute_path) then return { self.icon } end
end

return ScopeDecorator

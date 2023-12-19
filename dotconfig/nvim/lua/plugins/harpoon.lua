return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {"nvim-lua/plenary.nvim"},
  opts = {},
  config = function()
    vim.keymap.set("n", "<leader>ha", function() require("harpoon"):list():append() end)
    vim.keymap.set("n", "<leader>he", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end)

    vim.keymap.set("n", "<C-h>", function() require("harpoon"):list():select(1) end)
    vim.keymap.set("n", "<C-t>", function() require("harpoon"):list():select(2) end)
    vim.keymap.set("n", "<C-n>", function() require("harpoon"):list():select(3) end)
    vim.keymap.set("n", "<C-s>", function() require("harpoon"):list():select(4) end)
  end
}

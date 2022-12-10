local lsp = require('lsp-zero')
lsp.preset('recommended')

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

local luasnip = require('luasnip')

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

-- local cmp_select_opts = {behavior = cmp.SelectBehavior.Select}

lsp.setup_nvim_cmp({
    -- preselect = 'item',
    completion = {
        completeopt = 'menu, menuone, noselect'
    },
    mapping = lsp.defaults.cmp_mappings({
        -- ["<C-k>"] = cmp.mapping.select_prev_item(),
        -- ["<C-j>"] = cmp.mapping.select_next_item(),
        -- ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        -- ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        -- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        -- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        -- ["<C-e>"] = cmp.mapping {
        --     i = cmp.mapping.abort(),
        --     c = cmp.mapping.close(),
        -- },
        -- -- Accept currently selected item. If none selected, `select` first item.
        -- -- Set `select` to `false` to only confirm explicitly selected items.
        -- ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, {
                "i",
                "s",
            }),
        ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
                "i",
                "s",
            })
    })
})

lsp.on_attach(function(client, bufnr)
  local noremap = {buffer = bufnr, remap = false}
  local bind = vim.keymap.set

  bind('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<cr>', {buffer = bufnr, remap = true})
  bind('n', 'gF', 'buf.code_action()', {buffer = bufnr, remap = true})
  bind('x', 'gF', 'buf.range_code_action()', {buffer = bufnr, remap = true})
end)

lsp.set_preferences({
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

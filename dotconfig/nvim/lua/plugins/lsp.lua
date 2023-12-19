-- requires Neovim 0.8

----------------------------------------------------------------------------------------- On attach
local on_attach = function(a, b)
  local function severity_sort(diagnostics)
    if type(diagnostics) == 'number' then
      return {}
    end

    local sorted = {}
    for _, diag in ipairs(diagnostics) do
      if diag.severity == vim.lsp.protocol.DiagnosticSeverity.Error then
        table.insert(sorted, 1, diag)
      else
        table.insert(sorted, diag)
      end
    end
    return sorted
  end

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = {
      spacing = 4,
      severity_limit = 'Warning',
    },
    signs = true,
    update_in_insert = false,
    severity_sort = severity_sort,
  })

  vim.keymap.set('n',        'K',    "<CMD>lua vim.lsp.buf.hover()<CR>", {})
  vim.keymap.set('n',        'gd',   "<CMD>lua vim.lsp.buf.definition()<CR>", {})
  vim.keymap.set('n',        'gd',   "<CMD>lua vim.lsp.buf.declaration()<CR>", {})
  vim.keymap.set('n',        'gi',   "<CMD>lua vim.lsp.buf.implementation()<CR>", {})
  vim.keymap.set('n',        'go',   "<CMD>lua vim.lsp.buf.type_definition()<CR>", {})
  vim.keymap.set('n',        'gr',   "<CMD>lua vim.lsp.buf.references()<CR>", {})
  vim.keymap.set('n',        'gs',   "<CMD>lua vim.lsp.buf.signature_help()<CR>", {})
  vim.keymap.set('n',        '<f2>', "<CMD>lua vim.lsp.buf.rename()<CR>", {})
  vim.keymap.set({'n', 'x'}, '<f3>', "<CMD>lua vim.lsp.buf.format({async = true})<CR>", {})
  vim.keymap.set('n',        '<f4>', "<CMD>lua vim.lsp.buf.code_action()<CR>", {})
  vim.keymap.set('n',        'gl',   "<CMD>lua vim.diagnostic.open_float()<CR>", {})
  vim.keymap.set('n',        '[d',   "<CMD>lua vim.diagnostic.goto_prev()<CR>", {})
  vim.keymap.set('n',        ']d',   "<CMD>lua vim.diagnostic.goto_next()<CR>", {})
end

return {
  {
    "williamboman/mason.nvim",
    opts = {}
  },
  "neovim/nvim-lspconfig",
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers {
        function(server_name)
          require("lspconfig")[server_name].setup {
            on_attach = on_attach,
          }
        end,
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            on_attach = on_attach,
            settings = {
              Lua = {
                runtime = {
                  version = "LuaJIT",
                },
                diagnostics = {
                  globals = { "vim", "use", "require" },
                },
                -- workspace = {
                --   library = vim.api.nvim_get_runtime_file("", true),
                -- },
                -- telemetry = {
                --   enable = false,
                -- },
              },
            },
          })
        end
      }
    end
  }
}

-- LSP keymaps, server configuration, Mason tools installation. See `:help lsp-vs-treesitter`
return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    -- loaded with lspconfig so mason's bin dir is on PATH before servers start
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'saghen/blink.cmp', -- sets vim.lsp.config('*') capabilities on load
  },
  config = function()
    --  This function gets run when an LSP attaches to a particular buffer.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Rename the variable under your cursor.
        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- Telescope-based LSP pickers; telescope loads on first use
        local function pick(name)
          return function() require('telescope.builtin')[name]() end
        end
        map('grr', pick 'lsp_references', '[G]oto [R]eferences')
        map('gri', pick 'lsp_implementations', '[G]oto [I]mplementation')
        map('grd', pick 'lsp_definitions', '[G]oto [D]efinition')
        map('gO', pick 'lsp_document_symbols', '(G) [O]pen Document Symbols')
        map('gW', pick 'lsp_dynamic_workspace_symbols', '(G) Open [W]orkspace Symbols')
        map('grt', pick 'lsp_type_definitions', '[G]oto [T]ype Definition')

        -- Highlight references of the word under your cursor when it rests there for a little while.
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method('textDocument/documentHighlight', event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        -- Toggle inlay hints, if the language server supports them
        if client and client:supports_method('textDocument/inlayHint', event.buf) then
          map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    -- Servers installed by Mason. See `:help lsp-config` for information about keys and how to configure
    ---@type table<string, vim.lsp.Config>
    local servers = {
      stylua = {}, -- Used to format Lua code

      -- Special Lua Config, as recommended by neovim help docs
      lua_ls = {
        on_init = function(client)
          client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
          end

          local current_settings = client.config.settings --[[@as lspconfig.settings.lua_ls]]
          client.config.settings.Lua = vim.tbl_deep_extend('force', current_settings.Lua, {
            runtime = {
              version = 'LuaJIT',
              path = { 'lua/?.lua', 'lua/?/init.lua' },
            },
            workspace = {
              checkThirdParty = false,
              -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
              --  See https://github.com/neovim/nvim-lspconfig/issues/3189
              library = vim.api.nvim_get_runtime_file('', true),
            },
          })
        end,
        ---@type lspconfig.settings.lua_ls
        settings = {
          Lua = {
            format = { enable = false }, -- Disable formatting (formatting is done by stylua)
          },
        },
      },
    }

    -- Translates between nvim-lspconfig server names and mason.nvim package names (e.g. lua_ls <-> lua-language-server)
    require('mason-lspconfig').setup {
      automatic_enable = false,
    }

    local ensure_installed = vim.tbl_keys(servers or {})
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    for name, server in pairs(servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end

    -- [[ C# ]]
    -- Not Mason-managed. Server: `dotnet tool install -g csharp-ls`
    local csharp_solution = {}
    local function pick_solution(root, bufnr)
      local proj = vim.fs.root(bufnr, function(name) return name:match '%.csproj$' ~= nil end)
      if not proj then return end
      local needle = vim.fs.basename(proj) .. '/'
      for name, kind in vim.fs.dir(root) do
        if kind == 'file' and name:match '%.slnx?$' then
          local text = table.concat(vim.fn.readfile(vim.fs.joinpath(root, name)), '\n'):gsub('\\', '/')
          if text:find(needle, 1, true) then return name end
        end
      end
    end

    vim.lsp.config('csharp_ls', {
      cmd = function(dispatchers, config)
        local cmd = { 'csharp-ls' }
        local sln = csharp_solution[config.root_dir]
        if sln then vim.list_extend(cmd, { '--solution', sln }) end
        return vim.lsp.rpc.start(cmd, dispatchers, { cwd = config.root_dir })
      end,
      filetypes = { 'cs' },
      -- csharp-ls registers textDocument/definition dynamically for language "csharp", but nvim sends the filetype "cs"
      get_language_id = function() return 'csharp' end,
      -- root_markers does not glob; prefer the solution over a project over .git
      root_dir = function(bufnr, on_dir)
        local sln_root = vim.fs.root(bufnr, function(name) return name:match '%.slnx?$' ~= nil end)
        local root = sln_root or vim.fs.root(bufnr, function(name) return name:match '%.csproj$' ~= nil end) or vim.fs.root(bufnr, '.git')
        if sln_root and csharp_solution[sln_root] == nil then csharp_solution[sln_root] = pick_solution(sln_root, bufnr) or false end
        on_dir(root)
      end,
    })
    vim.lsp.enable 'csharp_ls'
  end,
}

return {
  {
    "dundalek/lazy-lsp.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    {"VonHeikemen/lsp-zero.nvim", branch = "v3.x"},
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
    },
    config = function()
      vim.o.signcolumn = "yes"
      require("lazy-lsp").setup {
        configs = {
          lua_ls = {
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          },
        },
        {
          excluded_servers = {
            "ccls",                            -- prefer clangd
            "denols",                          -- prefer eslint and ts_ls
            "docker_compose_language_service", -- yamlls should be enough?
            "flow",                            -- prefer eslint and ts_ls
            "ltex",                            -- grammar tool using too much CPU
            "quick_lint_js",                   -- prefer eslint and ts_ls
            "scry",                            -- archived on Jun 1, 2023
            "tailwindcss",                     -- associates with too many filetypes
            "biome",                           -- not mature enough to be default
            "oxlint",                          -- prefer eslint
          },
          preferred_servers = {
            markdown = {},
            python = { "basedpyright", "ruff" },
          },
       }
     }
    end,
  }
}
-- vim: ts=2 sts=2 sw=2 et

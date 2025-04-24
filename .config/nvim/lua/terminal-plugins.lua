return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release
    lazy = true,
    event = {
      "BufReadPre /home/g/Syncthing/notes/*.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp"
    },
    opts = {
      dir = "~/Syncthing/notes",
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      ui = { enable = false }
    },
  },

  { 
    "hrsh7th/nvim-cmp",
    lazy = true,
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      -- "hrsh7th/cmp-path",
      -- "hrsh7th/cmp-cmdline",
    },
    config = function()
      local cmp = require"cmp"
      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.snippet.expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
        })
      })
    end
  }
}
-- vim: ts=2 sts=2 sw=2 et

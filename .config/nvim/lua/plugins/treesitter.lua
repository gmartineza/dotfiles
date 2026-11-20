-- Used to highlight, edit, and navigate code. See `:help nvim-treesitter-intro`

-- tree-sitter CLI defaults to cl.exe on Windows; no MSVC installed, so point it at mingw gcc.
-- Called only before compiling parsers: the PATH lookups cost ~28ms at startup on Windows.
local cc_checked = false
local function set_cc()
  if cc_checked then return end
  cc_checked = true
  if vim.fn.has 'win32' == 1 and vim.fn.executable 'cl' == 0 and vim.fn.executable 'gcc' == 1 then vim.env.CC = 'gcc' end
end

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false, -- the main branch does not support lazy-loading
  build = function()
    set_cc()
    vim.cmd 'TSUpdate'
  end,
  config = function()
    ---@param buf integer
    ---@param language string
    local function treesitter_try_attach(buf, language)
      -- Check if the buffer is valid (might not be after install completes)
      if not vim.api.nvim_buf_is_valid(buf) then return end

      -- Check if a parser exists and load it
      if not vim.treesitter.language.add(language) then return end

      -- Enable syntax highlighting and other treesitter features
      vim.treesitter.start(buf, language)

      -- Enable treesitter based indentation if an indent query exists
      local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil
      if has_indent_query then vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
    end

    local available_parsers = require('nvim-treesitter').get_available()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local buf, filetype = args.buf, args.match

        local language = vim.treesitter.language.get_lang(filetype)
        if not language then return end

        local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

        if vim.tbl_contains(installed_parsers, language) then
          -- Enable the parser if it is already installed
          treesitter_try_attach(buf, language)
        elseif vim.tbl_contains(available_parsers, language) then
          -- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
          set_cc()
          require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
        else
          -- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
          treesitter_try_attach(buf, language)
        end
      end,
    })
  end,
}

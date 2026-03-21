---@module 'lazy'
---@type LazySpec
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  ---@module 'conform'
  ---@type conform.setupOpts
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      end
      return { timeout_ms = 500, lsp_format = 'fallback' }
    end,
    -- Only run formatters that are actually available on PATH.
    -- This makes the config work correctly in containers and minimal environments
    -- where only a subset of tools are installed.
    formatters = (function()
      local function exe(name)
        return { condition = function() return vim.fn.executable(name) == 1 end }
      end
      return {
        stylua = exe 'stylua',
        shfmt = exe 'shfmt',
        rustfmt = exe 'rustfmt',
        prettierd = exe 'prettierd',
        prettier = exe 'prettier',
        ruff_format = exe 'ruff',
        ruff_organize_imports = exe 'ruff',
        -- biome only runs when biome.json/biome.jsonc exists in the project root,
        -- so projects with .prettierrc naturally fall through to prettierd/prettier.
        biome = {
          condition = function() return vim.fn.executable 'biome' == 1 end,
          require_cwd = true,
        },
      }
    end)(),
    formatters_by_ft = {
      lua = { 'stylua' },
      rust = { 'rustfmt' },

      python = { 'ruff_format', 'ruff_organize_imports' },

      javascript = { 'biome', 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'biome', 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'biome', 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'biome', 'prettierd', 'prettier', stop_after_first = true },
      css = { 'biome', 'prettierd', 'prettier', stop_after_first = true },

      json = { 'biome', 'prettierd', 'prettier', stop_after_first = true },
      jsonc = { 'biome', 'prettierd', 'prettier', stop_after_first = true },
      yaml = { 'prettierd', 'prettier', stop_after_first = true },
      markdown = { 'prettierd', 'prettier', stop_after_first = true },

      sh = { 'shfmt' },
      bash = { 'shfmt' },
      zsh = { 'shfmt' },
    },
  },
}

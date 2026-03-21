---@module 'lazy'
---@type LazySpec
return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'

    -- Only register a linter if its binary is available on PATH.
    -- This keeps the config working in containers and minimal environments.
    local function if_exe(bin, linter)
      linter = linter or bin
      return vim.fn.executable(bin) == 1 and { linter } or {}
    end

    lint.linters_by_ft = {
      markdown = { 'markdownlint' },
      python = if_exe 'ruff',
      sh = if_exe 'shellcheck',
      bash = if_exe 'shellcheck',
      lua = if_exe 'luacheck',
      -- biome covers linting for JS/TS (nvim-lint name is 'biomejs')
      javascript = if_exe('biome', 'biomejs'),
      javascriptreact = if_exe('biome', 'biomejs'),
      typescript = if_exe('biome', 'biomejs'),
      typescriptreact = if_exe('biome', 'biomejs'),
      -- Rust: rust_analyzer runs clippy inline via LSP, no separate linter needed
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        if vim.bo.modifiable then
          lint.try_lint()
        end
      end,
    })
  end,
}

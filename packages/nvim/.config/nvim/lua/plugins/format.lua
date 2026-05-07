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
        require('conform').format {
          async = true,
          lsp_format = 'fallback',
        }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  ---@module 'conform'
  ---@type conform.setupOpts
  opts = function()
    local prettier_files = {
      '.prettierrc',
      '.prettierrc.json',
      '.prettierrc.yml',
      '.prettierrc.yaml',
      '.prettierrc.json5',
      '.prettierrc.js',
      '.prettierrc.cjs',
      '.prettierrc.mjs',
      'prettier.config.js',
      'prettier.config.cjs',
      'prettier.config.mjs',
    }

    local function exe(name)
      return function()
        return vim.fn.executable(name) == 1
      end
    end

    local function has_prettier(_, ctx)
      return vim.fs.root(ctx.buf, prettier_files) ~= nil
    end

    local function has_biome_no_prettier(self, ctx)
      return vim.fn.executable 'biome' == 1 and not has_prettier(self, ctx)
    end

    return {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = {
          c = true,
          cpp = true,
        }

        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        end

        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end,
      formatters = {
        stylua = { condition = exe 'stylua' },
        shfmt = { condition = exe 'shfmt' },
        rustfmt = { condition = exe 'rustfmt' },
        ruff_format = { condition = exe 'ruff' },
        ruff_organize_imports = { condition = exe 'ruff' },
        -- biome runs when no prettier config is present; biome-organize-imports
        -- uses --assist-enabled=true to sort imports (Biome 2.x assist module)
        biome = { condition = has_biome_no_prettier },
        ['biome-organize-imports'] = { condition = has_biome_no_prettier },
        prettierd = {
          condition = function(self, ctx)
            return vim.fn.executable 'prettierd' == 1 and has_prettier(self, ctx)
          end,
        },
        prettier = {
          condition = function(self, ctx)
            return vim.fn.executable 'prettier' == 1 and has_prettier(self, ctx)
          end,
        },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        rust = { 'rustfmt' },

        python = { 'ruff_format', 'ruff_organize_imports' },

        -- Conditions on each formatter handle the prettier-vs-biome choice:
        -- prettier/prettierd run when a prettier config exists, biome otherwise.
        javascript = { 'prettierd', 'prettier', 'biome', 'biome-organize-imports' },
        javascriptreact = { 'prettierd', 'prettier', 'biome', 'biome-organize-imports' },
        typescript = { 'prettierd', 'prettier', 'biome', 'biome-organize-imports' },
        typescriptreact = { 'prettierd', 'prettier', 'biome', 'biome-organize-imports' },
        css = { 'prettierd', 'prettier', 'biome', 'biome-organize-imports' },

        json = { 'prettierd', 'prettier', 'biome', 'biome-organize-imports' },
        jsonc = { 'prettierd', 'prettier', 'biome', 'biome-organize-imports' },
        yaml = { 'prettierd', 'prettier', stop_after_first = true },
        markdown = { 'prettierd', 'prettier', stop_after_first = true },

        sh = { 'shfmt' },
        bash = { 'shfmt' },
        zsh = { 'shfmt' },
      },
    }
  end,
}

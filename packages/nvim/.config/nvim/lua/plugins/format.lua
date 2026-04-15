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
    local function exe(name)
      return function()
        return vim.fn.executable(name) == 1
      end
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
        stylua = {
          condition = exe 'stylua',
        },
        shfmt = {
          condition = exe 'shfmt',
        },
        rustfmt = {
          condition = exe 'rustfmt',
        },
        ruff_format = {
          condition = exe 'ruff',
        },
        ruff_organize_imports = {
          condition = exe 'ruff',
        },
        biome = {
          condition = function(_, ctx)
            return vim.fn.executable 'biome' == 1 and has_root_file(ctx.buf, {
              'biome.json',
              'biome.jsonc',
            })
          end,
        },
        prettierd = {
          condition = exe 'prettierd',
        },
        prettier = {
          condition = exe 'prettier',
        },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        rust = { 'rustfmt' },

        python = { 'ruff_format', 'ruff_organize_imports' },

        javascript = { 'biome', 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = {
          'biome',
          'prettierd',
          'prettier',
          stop_after_first = true,
        },
        typescript = { 'biome', 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = {
          'biome',
          'prettierd',
          'prettier',
          stop_after_first = true,
        },
        css = { 'biome', 'prettierd', 'prettier', stop_after_first = true },

        json = { 'biome', 'prettierd', 'prettier', stop_after_first = true },
        jsonc = { 'biome', 'prettierd', 'prettier', stop_after_first = true },
        yaml = { 'prettierd', 'prettier', stop_after_first = true },
        markdown = { 'prettierd', 'prettier', stop_after_first = true },

        sh = { 'shfmt' },
        bash = { 'shfmt' },
        zsh = { 'shfmt' },
      },
    }
  end,
}

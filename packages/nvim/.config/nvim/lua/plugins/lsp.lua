---@module 'lazy'
---@type LazySpec
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    local function executable(bin)
      return vim.fn.executable(bin) == 1
    end

    local function enable_if_present(server, bin, opts)
      if not executable(bin) then
        return
      end

      if opts then
        vim.lsp.config(server, opts)
      end

      vim.lsp.enable(server)
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, {
            buffer = event.buf,
            desc = 'LSP: ' .. desc,
          })
        end

        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', {
          'n',
          'x',
        })
        map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
          return
        end

        local disable_formatting_for = {
          lua_ls = true,
          tsgo = true,
          html = true,
          cssls = true,
          tailwindcss = true,
        }

        if disable_formatting_for[client.name] then
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end

        if client:supports_method('textDocument/documentHighlight', event.buf) then
          local highlight_group = vim.api.nvim_create_augroup('lsp-highlight', {
            clear = false,
          })

          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_group,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_group,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach', {
              clear = true,
            }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds {
                group = 'lsp-highlight',
                buffer = event2.buf,
              }
            end,
          })
        end

        if client:supports_method('textDocument/inlayHint', event.buf) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    enable_if_present('rust_analyzer', 'rust-analyzer', {
      settings = {
        ['rust-analyzer'] = {
          cargo = { allFeatures = true },
          check = { command = 'clippy' },
          procMacro = { enable = true },
        },
      },
    })

    enable_if_present('ruff', 'ruff')

    enable_if_present('basedpyright', 'basedpyright-langserver', {
      settings = {
        basedpyright = {
          analysis = {
            typeCheckingMode = 'recommended',
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
          },
        },
      },
    })

    vim.lsp.config('lua_ls', {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            version = 'LuaJIT',
            path = { 'lua/?.lua', 'lua/?/init.lua' },
          },
          workspace = {
            checkThirdParty = false,
            library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
              '${3rd}/luv/library',
              '${3rd}/busted/library',
            }),
          },
        })
      end,
      settings = { Lua = {} },
    })

    vim.lsp.config('tsgo', {
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
      },
    })

    vim.lsp.config('html', {
      filetypes = { 'html' },
    })

    vim.lsp.config('cssls', {
      filetypes = { 'css', 'scss', 'less' },
    })

    vim.lsp.config('tailwindcss', {
      filetypes = {
        'html',
        'css',
        'scss',
        'less',
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
      },
    })

    vim.lsp.config('tombi', {
      filetypes = { 'toml' },
    })

    -- Any server installed via :MasonInstall is enabled automatically.
    -- vim.lsp.config() calls above are applied before this runs.
    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          vim.lsp.enable(server_name)
        end,
      },
    }
  end,
}

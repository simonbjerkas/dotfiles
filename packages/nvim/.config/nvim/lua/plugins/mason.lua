---@module 'lazy'
---@type LazySpec[]
return {
  {
    'mason-org/mason.nvim',
    opts = {},
  },
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {
      ensure_installed = {
        'lua_ls',
        'html',
        'cssls',
        'tailwindcss',
        'tsgo',
        'tombi',
      },
      automatic_enable = {
        'lua_ls',
        'html',
        'cssls',
        'tailwindcss',
        'tsgo',
        'tombi',
      },
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      'mason-org/mason.nvim',
    },
    opts = {
      ensure_installed = {
        'stylua',
        'biome',
        'prettierd',
      },
      run_on_start = true,
      debounce_hours = 12,
    },
  },
}

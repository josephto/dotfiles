return {
  {
    'mason-org/mason.nvim',
    opts = {},
  },
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = { 'mason-org/mason.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      ensure_installed = { 'ts_ls' }, -- TypeScript/JavaScript language server, drives semantic highlighting
    },
  },
  {
    'neovim/nvim-lspconfig',
    lazy = false,
  },
}

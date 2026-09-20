local filetypes = {
  'typescript', 'typescriptreact',
  'javascript', 'javascriptreact',
  'json', 'lua', 'vim', 'help', 'markdown',
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install({
        'typescript', 'tsx', 'javascript', 'json',
        'lua', 'vim', 'vimdoc', 'markdown', 'markdown_inline',
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = filetypes,
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
}

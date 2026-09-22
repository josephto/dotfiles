return {
  {
    'Mofiqul/vscode.nvim',
    priority = 1000, -- load before other UI plugins so highlight groups exist
    lazy = false,
    opts = {
      style = 'dark', -- match VS Code's Dark+ theme
    },
    config = function(_, opts)
      require('vscode').setup(opts)
      vim.cmd.colorscheme('vscode')
    end,
  },
}

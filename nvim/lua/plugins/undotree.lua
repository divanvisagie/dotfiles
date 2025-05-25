return {
  "mbbill/undotree",
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  config = function()
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
  end
}

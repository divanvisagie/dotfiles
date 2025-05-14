return {
  "klen/nvim-test",
  config = function()
    require('nvim-test').setup()
    vim.api.nvim_set_keymap('n', '<leader>tf', ':TestFile<CR>', {noremap=true, silent=true})
    vim.api.nvim_set_keymap('n', '<leader>tn', ':TestNearest<CR>', {noremap=true, silent=true})
  end
} 

return {
  "tpope/vim-fugitive",
  config = function()
    vim.api.nvim_set_keymap('n', '<leader>gg', '<cmd>G<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>gs', '<cmd>Gvdiffsplit<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>gb', '<cmd>Git blame<CR>', { noremap = true, silent = true })
  end
} 

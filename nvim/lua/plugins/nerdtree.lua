return {
  "preservim/nerdtree",
  config = function()
    vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
    vim.g.NERDTreeShowHidden = 1
    vim.api.nvim_set_keymap('n', '<leader>nt', '<cmd>NERDTreeToggle<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>nf', '<cmd>NERDTreeFind<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>haf', '<cmd>NERDTreeFind<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<D-b>', '<cmd>NERDTreeToggle<CR>', { noremap = true, silent = true })
  end
}

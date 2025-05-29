return {
  "preservim/nerdtree",
  config = function()
    vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
    vim.g.NERDTreeShowHidden = 1
    -- Keep NERDTree hidden on startup
    vim.g.NERDTreeAutoOpenOnStartup = 0
    vim.g.NERDTreeHijackNetrw = 0
    vim.api.nvim_set_keymap('n', '<leader>nt', '<cmd>NERDTreeToggle<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>nf', '<cmd>NERDTreeFind<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<D-b>', '<cmd>NERDTreeToggle<CR>', { noremap = true, silent = true })
  end
}

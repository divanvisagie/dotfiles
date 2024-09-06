-- NERDTree toggle mapping
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- Show hidden files in NERDTree
vim.g.NERDTreeShowHidden = 1

-- Toggle NERDTree
vim.api.nvim_set_keymap('n', '<leader>nt', '<cmd>NERDTreeToggle<CR>', { noremap = true, silent = true })

-- Find the active file in NERDTree
vim.api.nvim_set_keymap('n', '<leader>nf', '<cmd>NERDTreeFind<CR>', { noremap = true, silent = true })

-- Nested mapping for hierarchical shortcut: <leader>h -> a -> f
vim.api.nvim_set_keymap('n', '<leader>haf', '<cmd>NERDTreeFind<CR>', { noremap = true, silent = true })

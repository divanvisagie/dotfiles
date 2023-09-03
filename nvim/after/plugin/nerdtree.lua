-- NERDTree toggle mapping
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', {noremap=true, silent=true})

-- Mapping to find the active file in NERDTree
vim.api.nvim_set_keymap('n', '<leader>haf', ':NERDTreeFind<CR>', {noremap = true, silent = true})

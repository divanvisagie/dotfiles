-- Git status
vim.api.nvim_set_keymap('n', '<leader>gg', '<cmd>G<CR>', { noremap = true, silent = true })

-- Split vertical diff
vim.api.nvim_set_keymap('n', '<leader>gs', '<cmd>Gvdiffsplit<CR>', { noremap = true, silent = true })

-- Git blame
vim.api.nvim_set_keymap('n', '<leader>gb', '<cmd>Git blame<CR>', { noremap = true, silent = true })

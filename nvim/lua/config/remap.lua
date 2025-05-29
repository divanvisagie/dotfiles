vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set('n', '<leader>haf', vim.cmd.Ex)

-- Allows you to move the selected lines up or down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.api.nvim_set_keymap('n', '<leader>%', ':vsplit<CR>', { noremap = true, silent = true }) -- vertical split
vim.api.nvim_set_keymap('n', '<leader>"', ':split<CR>', { noremap = true, silent = true })  -- horizontal split

-- go to previous buffer

-- Toggle line numbers in context
vim.api.nvim_set_keymap('n', '<leader>ln', ':setlocal nonumber norelativenumber<CR>', { noremap = true })

-- Window resizing
vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize +2<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-Left>', ':vertical resize -2<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-Down>', ':resize +2<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-Up>', ':resize -2<CR>', { noremap = true })

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Allows you to move the selected lines up or down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")


vim.api.nvim_set_keymap('n', '<leader>%', ':vsplit<CR>', {noremap = true, silent = true}) -- vertical split
vim.api.nvim_set_keymap('n', '<leader>"', ':split<CR>', {noremap = true, silent = true}) -- vertical split


vim.api.nvim_set_keymap('n', '<leader>bp', ':bp<CR>', {noremap = true, silent = true})
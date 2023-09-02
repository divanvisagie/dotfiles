local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles'})
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[G]it Files'})
vim.keymap.set('n', '<leader>fs', function()
	builtin.grep_string( { search = vim.fn.input("Grep > ") });
end, { desc = '[F]ind grep [S]tring'})

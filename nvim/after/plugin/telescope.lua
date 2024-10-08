-- Require Telescope and its builtins
require('telescope').setup()

local builtin = require('telescope.builtin')

-- Key mappings for Telescope functions
vim.keymap.set('n', '<leader>ff', function()
  builtin.find_files({
    find_command = {'rg', '--files', '--hidden', '--glob', '!.git/*'},
  })
end, { desc = '[F]ind [F]iles' })

vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[G]it Files' })

vim.keymap.set('n', '<leader>fs', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = '[F]ind grep [S]tring' })


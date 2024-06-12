require('telescope').setup()
local builtin = require('telescope.builtin')
--vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles'})
vim.keymap.set('n', '<leader>ff', function()
  builtin.find_files({
    find_command = {'rg', '--files', '--hidden', '--glob', '!.git/*'},
  })
end, { desc = '[F]ind [F]iles'})
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[G]it Files'})
vim.keymap.set('n', '<leader>fs', function()
	builtin.grep_string( { search = vim.fn.input("Grep > ") });
end, { desc = '[F]ind grep [S]tring'})

vim.keymap.set('n', '<leader>cs', function()
  builtin.find_files( { 
    find_command = {'csep', '--vimgrep'},
  });
end, { desc = '[C]sep'})


local function Csep(pattern)
    -- Construct the ripgrep command
    local command = 'csep --vimgrep ' .. vim.fn.shellescape(pattern)
    
    -- Capture the output of the command
    local output = vim.fn.systemlist(command)
    
    -- Set the quickfix list with the command output
    vim.fn.setqflist({}, 'r', { title = 'Csep Search', lines = output })
    
    -- Open the quickfix window
    vim.cmd('copen')
end

-- Create a key mapping for the function call
vim.keymap.set('n', '<leader>cs', function()
    -- Prompt the user for a search pattern
    local pattern = vim.fn.input('Csep > ')
    
    -- Call the function with the search pattern
    Csep(pattern)
end, { desc = '[C]sep'})


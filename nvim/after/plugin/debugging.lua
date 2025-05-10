-- https://davelage.com/posts/nvim-dap-getting-started/

-- TypeScript
-- Create an autocommand group for TypeScript file bindings
vim.api.nvim_create_augroup('TypeScriptBindings', { clear = true })

function Insert_console_log()
  -- Get current line number and file name
  local line_num = vim.fn.line('.')
  local file_name = vim.fn.expand('%:p')
  --- get relative path to file
  file_name = vim.fn.fnamemodify(file_name, ':~:.')

  -- Construct the console.log statement
  local log_statement = string.format("console.log('BREAK', '%s:%d', this || '');", file_name, line_num+1)

  -- Use nvim_buf_set_lines to insert the log statement
  vim.api.nvim_buf_set_lines(0, line_num, line_num, false, { log_statement })
end
-- Define key mappings for TypeScript files
vim.api.nvim_create_autocmd('FileType', {
  group = 'TypeScriptBindings',
  pattern = 'typescript',
  callback = function()
    -- Define a Lua function that inserts a console.log statement with line number and file name

    -- Set keybinding to insert console.log on the next line and run the Lua function
    vim.api.nvim_buf_set_keymap(0, 'n', '<Leader>b', [[:lua Insert_console_log()<CR>]], { noremap = true, silent = true })
  end,
})

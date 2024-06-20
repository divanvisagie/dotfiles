-- https://davelage.com/posts/nvim-dap-getting-started/
local dap = require('dap')

-- Rust debug config
dap.adapters.lldb = {
  type = 'executable',
  command = '~/.local/share/nvim/mason/bin/codelldb',
  name = "lldb"
}

-- dap config for rust
local lldb = {
	name = "Launch lldb",
	type = "lldb", -- matches the adapter
	request = "launch", -- could also attach to a currently running process
	program = function()
		return vim.fn.input(
			"Path to executable: ",
			vim.fn.getcwd() .. "/",
			"file"
		)
	end,
	cwd = "${workspaceFolder}",
	stopOnEntry = false,
	args = {},
	runInTerminal = false,
}

require('dap').configurations.rust = {
	lldb -- different debuggers or more configurations can be used here
}
vim.api.nvim_set_keymap('n', '<leader>dc', ':lua require"dap".continue()<CR>', { noremap = true, silent = true })

-- Create an autocommand group for Rust file bindings
vim.api.nvim_create_augroup('RustBindings', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'RustBindings',
  pattern = 'rust',
  callback = function()
    local n = "n"
    vim.keymap.set(n, '<leader>dk', function() require('dap').continue() end)
    vim.keymap.set(n, '<leader>dl', function() require('dap').run_last() end)
    vim.keymap.set(n, '<leader>b', function() require('dap').toggle_breakpoint() end)
  end,
})

-- TypeScript
-- Create an autocommand group for TypeScript file bindings
vim.api.nvim_create_augroup('TypeScriptBindings', { clear = true })

-- Define key mappings for TypeScript files
vim.api.nvim_create_autocmd('FileType', {
  group = 'TypeScriptBindings',
  pattern = 'typescript',
  callback = function()
    -- Set keybinding to insert console.log on the next line
    vim.api.nvim_buf_set_keymap(0, 'n', '<Leader>b', "oconsole.log('BREAKPOINT', this || 'no value');<ESC>", { noremap = true, silent = true })
  end,
})

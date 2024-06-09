-- https://davelage.com/posts/nvim-dap-getting-started/
local dap = require('dap')

-- Typescript debug config
dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    -- 💀 Make sure to update this path to point to your installation
    args = {"~/.local/share/nvim/mason/bin/js-debug-adapter", "${port}"},
  }
}

dap.configurations.typescript = {
  {
    type = 'pwa-node',
    request = 'attach',
    name = "Attach to Process",
    processId = require'dap.utils'.pick_process,
    cwd = "${workspaceFolder}",
    attachSimplePort = 9229,  -- default debug port for Node.js
  },
}

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

local n = "n"
vim.keymap.set(n, '<leader>dk', function() require('dap').continue() end)
vim.keymap.set(n, '<leader>dl', function() require('dap').run_last() end)
vim.keymap.set(n, '<leader>b', function() require('dap').toggle_breakpoint() end)
-- nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
-- nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
-- nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
-- nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
-- nnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
-- nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
-- nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
-- nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
-- nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>

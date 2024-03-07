local dap = require("dap")
-- https://github.com/anasrar/.dotfiles/blob/4c444c3ab2986db6ca7e2a47068222e47fd232e2/neovim/.config/nvim/lua/rin/DAP/languages/typescript.lua
require('dap-vscode-js').setup({
  node_path = 'node',
  debugger_path = os.getenv('HOME') .. '/.local/share/nvim/site/pack/packer/opt/vscode-js-debug',
  adapters = { 'pwa-node', 'node2', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})

dap.configurations['typescript'] = {
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Launch Current File (pwa-node)',
    cwd = vim.fn.getcwd(),
    args = { '${file}' },
    sourceMaps = true,
    protocol = 'inspector',
  },
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Launch Current File (pwa-node with ts-node)',
    cwd = vim.fn.getcwd(),
    runtimeArgs = { '--loader', 'ts-node/esm' },
    runtimeExecutable = 'node',
    args = { '${file}' },
    sourceMaps = true,
    protocol = 'inspector',
    skipFiles = { '<node_internals>/**', 'node_modules/**' },
    resolveSourceMapLocations = {
      "${workspaceFolder}/**",
      "!**/node_modules/**",
    },
  },
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Launch Test Current File (pwa-node with jest)',
    cwd = vim.fn.getcwd(),
    runtimeArgs = { '${workspaceFolder}/node_modules/.bin/jest' },
    runtimeExecutable = 'node',
    args = { '${file}', '--coverage', 'false' },
    rootPath = '${workspaceFolder}',
    sourceMaps = true,
    console = 'integratedTerminal',
    internalConsoleOptions = 'neverOpen',
    skipFiles = { '<node_internals>/**', 'node_modules/**' },
  },
  {
    type = 'pwa-node',
    request = 'attach',
    name = 'Attach Program (pwa-node)',
    cwd = vim.fn.getcwd(),
    processId = require('dap.utils').pick_process,
    skipFiles = { '<node_internals>/**' },
  },
}


require("nvim-dap-virtual-text").setup()
require('dap-go').setup()

dap.adapters.go = function(callback, _)
  -- Wait for delve to start
  vim.defer_fn(function()
      callback({ type = "server", host = "127.0.0.1", port = "port" })
    end,
    100)
end

dap.configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    program = "${file}",
  }
}
---- 

-- Rust debugger setup
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/lib/llvm-14/bin/lldb-vscode', -- Adjust the path to lldb-vscode if needed
  --command = '/usr/bin/lldb', -- Adjust the path to lldb-vscode if needed
  name = "lldb"
}

dap.configurations.rust = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    
    -- if you want to use external terminal
    externalConsole = false,

    -- Environment variables
    env = function()
      local variables = {}
      -- Set your desired environment variables here
      return variables
    end,
  },
  {
    -- Attach to Process configuration with updated user prompts
    name = "Attach to Process",
    type = "lldb",
    request = "attach",
    pid = function()
      local binary_name = vim.fn.input('Binary name: ')
      local output = vim.fn.system('pidof ' .. binary_name)
      if output == "" then
        print("No running process found for " .. binary_name)
        return nil
      end
      local pid = vim.fn.input('PID to attach: ', vim.fn.trim(output))
      pid = tonumber(pid)
      if not pid then
        print("Invalid PID. Please enter a numeric PID.")
        return nil
      end
      return pid
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

-- Keymaps
vim.keymap.set('n', '<leader>da', require 'dap'.continue, { desc = 'Debug Continue' })
vim.keymap.set('n', '<leader>do', require 'dap'.step_over, { desc = 'Step Over' })
vim.keymap.set('n', '<leader>di', require 'dap'.step_into, { desc = 'Step Into' })
vim.keymap.set('n', '<leader>ds', require 'dap'.step_out, { desc = 'Step Out' })
vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)

vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>", { desc = 'Open the dap' })

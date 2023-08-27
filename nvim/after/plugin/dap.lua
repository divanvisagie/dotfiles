require("dap").adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    -- 💀 Make sure to update this path to point to your installation
    args = {"/path/to/js-debug/src/dapDebugServer.js", "${port}"},
  }
}
require("dap").configurations.javascript = {
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach Debugger",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
}

-- Golang
require('dap-go').setup()

local dap, dapui =require("dap"),require("dapui")
dap.listeners.after.event_initialized["dapui_config"]=function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"]=function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"]=function()
  dapui.close()
end

dap.adapters.go = function(callback, _)
  -- Wait for delve to start
    vim.defer_fn(function()
        callback({type = "server", host = "127.0.0.1", port = "port"})
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



-- Keymaps
vim.keymap.set('n', '<F5>', require 'dap'.continue)
vim.keymap.set('n', '<F10>', require 'dap'.step_over)
vim.keymap.set('n', '<F11>', require 'dap'.step_into)
vim.keymap.set('n', '<F12>', require 'dap'.step_out)
vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)

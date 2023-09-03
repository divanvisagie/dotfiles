local dap = require("dap")

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = 9229,
  executable = {
    command = "node",
    args = {os.getenv('HOME') .. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}"},
  }
}

dap.configurations.javascript = {
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach Debugger",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
}

dap.configurations.typescript = {
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

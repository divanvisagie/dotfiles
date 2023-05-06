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

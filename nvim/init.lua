require("config")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugin_specs = {}
local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"
local plugin_files = vim.fn.globpath(plugin_dir, "*.lua", false, true)
for _, file in ipairs(plugin_files) do
  local spec = dofile(file)
  table.insert(plugin_specs, spec)
end

require("lazy").setup(plugin_specs)

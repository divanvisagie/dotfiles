require("jester").setup({
  path_to_jest_run = 'npx jest', -- used to run tests
  dap = {
    console = "externalTerminal"
  }
})


-- Jester mapping
vim.api.nvim_set_keymap('n', '<leader>j', ':lua require"jester".run()<CR>', {noremap=true, silent=true})

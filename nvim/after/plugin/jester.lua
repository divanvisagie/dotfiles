require("jester").setup({
  path_to_jest_run = 'npx jest', -- used to run tests
  dap = {
    console = "externalTerminal"
  }
})


-- Jester mapping
vim.api.nvim_set_keymap('n', '<leader>jj', ':lua require"jester".run()<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>jd', ':lua require"jester".debug()<CR>', {noremap=true, silent=true})

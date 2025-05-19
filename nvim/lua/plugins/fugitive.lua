return {
  "tpope/vim-fugitive",
  config = function()
    vim.api.nvim_set_keymap('n', '<leader>gg', '<cmd>G<CR>',
      { noremap = true, silent = true, desc = "Fugitive: Git status" })
    vim.api.nvim_set_keymap('n', '<leader>gs', '<cmd>Gvdiffsplit<CR>',
      { noremap = true, silent = true, desc = "Fugitive: Git diff split" })
    vim.api.nvim_set_keymap('n', '<leader>gb', '<cmd>Git blame<CR>',
      { noremap = true, silent = true, desc = "Fugitive: Git blame" })
    vim.api.nvim_set_keymap('n', '<leader>gi', '<cmd>Git diff<CR>',
      { noremap = true, silent = true, desc = "Fugitive: Inline git diff" })
  end
}

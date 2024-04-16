require('refactoring').setup({})
vim.keymap.set("n", "<leader>ree", ":Refactor extract ", { desc = "Extract" })
vim.keymap.set("n", "<leader>ref", ":Refactor extract_to_file", { desc = "Extract to file"})

vim.keymap.set("n", "<leader>rev", ":Refactor extract_var")

vim.keymap.set("n", "<leader>riv", ":Refactor inline_var")
vim.keymap.set( "n", "<leader>rif", ":Refactor inline_func")

vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")


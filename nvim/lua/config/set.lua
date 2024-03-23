vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 8
vim.opt.clipboard = "unnamedplus"
vim.opt.undolevels = 10000
-- set folding
vim.opt.foldmethod = "indent"
-- do not fold by default
vim.opt.foldlevel = 99

vim.o.termguicolors = true
vim.cmd [[colorscheme default]]


vim.api.nvim_set_keymap('n', '<C-j>', ':resize -2<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', ':resize +2<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-h>', ':vertical resize -2<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', ':vertical resize +2<CR>', {noremap = true})

vim.opt.nu = true
vim.opt.relativenumber = true

-- Don't use swap files
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 8
vim.opt.clipboard = "unnamedplus"
vim.opt.undolevels = 10000

-- Set folding
vim.opt.foldmethod = "indent"
-- Do not fold by default
vim.opt.foldlevel = 99

-- Set lastatatus
vim.opt.laststatus = 3

-- Set default splitting behaviour
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.o.termguicolors = true

vim.api.nvim_set_keymap('n', '<C-j>', ':resize -2<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', ':resize +2<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-h>', ':vertical resize -2<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', ':vertical resize +2<CR>', {noremap = true})

-- Apply specific rules to markdown files
vim.api.nvim_exec([[ 
  autocmd FileType markdown setlocal formatoptions+=t 
  autocmd FileType markdown setlocal wrap
  autocmd FileType markdown setlocal colorcolumn=0
]], false) 


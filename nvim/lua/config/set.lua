vim.opt.nu = true
vim.opt.relativenumber = true
-- dont use swap files
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
-- set folding
vim.opt.foldmethod = "indent"
-- do not fold by default
vim.opt.foldlevel = 99

--set lastatatus
vim.opt.laststatus = 3

--set default splitting behaviour
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

function ChatGipity()
  local buf_name = "~/.cache/chat-gipity"
  local existing_bufnr = vim.fn.bufnr(buf_name)

  -- Check if the buffer is already open
  if existing_bufnr == -1 then
    -- Open new vertical split with the buffer
    vim.cmd("vsplit " .. buf_name)
    -- Set filetype to markdown for the new buffer
    vim.bo.filetype = 'markdown'
  else
    -- Split and display the existing buffer
    vim.cmd('vsplit')
    vim.cmd('buffer ' .. existing_bufnr)
  end
end

vim.api.nvim_set_keymap('n', '<leader>cg', ':lua ChatGipity()<CR>', {noremap = true})

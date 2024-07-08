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

function GetVisualSelection()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  local start_line = start_pos[2]
  local start_col = start_pos[3]
  local end_line = end_pos[2]
  local end_col = end_pos[3]

  if start_line == end_line then
    return vim.fn.getline(start_line):sub(start_col, end_col)
  else
    local lines = vim.fn.getline(start_line, end_line)
    lines[1] = lines[1]:sub(start_col, -1)
    lines[#lines] = lines[#lines]:sub(1, end_col)
    return table.concat(lines, "\n")
  end
end

function AddSelectionToQuickfix()
  -- Obtain text from visual selection
  local line = GetVisualSelection()
  print(line)

  -- The line is quickfix list compatible, we need to extract each value
  local filename = ''
  local line_num = 0
  local body = ''

  -- first we split values by : or space
  local parts = vim.fn.split(line, '[: ]')

  for part_idx, part in ipairs(parts) do
    if part_idx == 1 then
      filename = part
    end
    if part_idx == 2 then
      line_num = tonumber(part)
    end
    if part_idx > 2 then
        body = body .. part
    end
  end

  local qf_list = {}
  table.insert(qf_list, {
    filename = filename,
    lnum = line_num,  -- Line number
    col = 1,                        -- Column number
    text = body                     -- Text
  })

  vim.fn.setqflist(qf_list, 'a')  -- Append to the current quickfix list
  if vim.fn.empty(vim.fn.getqflist()) == 0 then
      vim.cmd('copen')
  end
end

vim.api.nvim_set_keymap('v', '<leader>qf', ":lua AddSelectionToQuickfix()<CR>", { noremap = true, silent = true })



-- Set up quickfix builder
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

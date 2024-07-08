
function Today(filename)
  local date = os.date("*t")
  local year = date.year
  local month = string.format("%02d", date.month)
  local day = string.format("%02d", date.day)
  local journal_path = "~/Documents/Resources/Journal/" .. year .. "/" .. month .. "/" .. day .. "/" .. filename .. ".md"
  local buf_name = vim.fn.expand(journal_path)
  local existing_bufnr = vim.fn.bufnr(buf_name)

  -- Check if the buffer is already open and visible in any window
  local win_id = vim.fn.win_findbuf(existing_bufnr)

  if existing_bufnr == -1 then
    -- Buffer does not exist, create it
    vim.cmd("vsplit " .. buf_name)
    vim.bo.filetype = 'markdown'
  elseif #win_id == 0 then
    -- Buffer exists, but not displayed, open in a new split
    vim.cmd("vsplit")
    vim.cmd("buffer " .. existing_bufnr)
  else
    -- Buffer is already displayed, focus on it
    vim.cmd("buffer " .. existing_bufnr)
  end
end

vim.api.nvim_set_keymap('n', '<leader>td', ':lua Today("journal")<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>cg', ':lua Today("chatbot")<CR>', {noremap = true})


function Today(filename)
  local date = os.date("*t")
  local year = date.year
  local month = string.format("%02d", date.month)
  local day = string.format("%02d", date.day)
  local journal_path = "~/Documents/Resources/Journal/" .. year .. "/" .. month .. "/" .. day .. "/" .. filename .. ".md" 
  local buf_name = vim.fn.expand(journal_path)
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

vim.api.nvim_set_keymap('n', '<leader>td', ':lua Today("journal")<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>cg', ':lua Today("chatbot")<CR>', {noremap = true})

-- Utility function to ensure a directory exists
function EnsureDirectoryExists(path)
  -- Use os.execute to create the directory if it doesn't exist
  os.execute("mkdir -p " .. vim.fn.shellescape(path))
end

function ExpandHomePath(path)
  return path:gsub("^~", os.getenv("HOME"))
end

-- General-purpose function to open a buffer
function OpenBuffer(full_path)
  local buf_name = vim.fn.expand(full_path)
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

-- Function to open the journal with a dated directory structure
function OpenJournal()
  local date = os.date("*t")
  local year = date.year
  local month = string.format("%02d", date.month)
  local day = string.format("%02d", date.day)
  local journal_dir = ExpandHomePath("~/Documents/Resources/Journal/")
  local journal_path = journal_dir .. year .. "-" .. month.. "-" .. day .. ".md"
  -- Ensure the directory exists
  EnsureDirectoryExists(journal_dir)
  OpenBuffer(journal_path)
end

function OpenChat()
  local date = os.date("*t")
  local year = date.year
  local month = string.format("%02d", date.month)
  local day = string.format("%02d", date.day)
  local journal_dir = ExpandHomePath("~/Documents/Archives/Chat/")
  local journal_path = journal_dir .. year .. "-" .. month.. "-" .. day .. ".md"
  -- Ensure the directory exists
  EnsureDirectoryExists(journal_dir)
  OpenBuffer(journal_path)
end

-- Function to open the long-running todos file directly
function OpenLongRunningTodos()
  local todos_dir = ExpandHomePath("~/Documents/Projects/Todos/")
  local todos_path = todos_dir .. "todos.md"
  -- Ensure the directory exists
  EnsureDirectoryExists(todos_dir)
  OpenBuffer(todos_path)
end

-- Key mappings
vim.api.nvim_set_keymap('n', '<leader>td', ':lua OpenJournal("journal")<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>cg', ':lua OpenChat("chatbot")<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>lt', ':lua OpenLongRunningTodos()<CR>', { noremap = true })

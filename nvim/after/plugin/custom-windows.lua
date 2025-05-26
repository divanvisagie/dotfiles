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

-- Track the current chat buffer
local current_chat_bufnr = nil

-- Function to open the journal with a dated directory structure
function OpenJournal()
  local date = os.date("*t")
  local year = date.year
  local month = string.format("%02d", date.month)
  local day = string.format("%02d", date.day)
  local journal_dir = ExpandHomePath("~/Documents/Notes/Resources/Journal/")
  local journal_path = journal_dir .. year .. "-" .. month .. "-" .. day .. ".md"
  -- Ensure the directory exists
  EnsureDirectoryExists(journal_dir)
  OpenBuffer(journal_path)
end

function OpenChat()
  -- Start by getting the git root or cwd
  local root_dir = vim.fn.getcwd()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if git_root and git_root ~= "" and not git_root:match("fatal") then
    root_dir = git_root
  end

  -- Create the unique hash
  local salt = root_dir
  local unique_hash = vim.fn.system("echo -n '" .. salt .. "' | shasum -a 256 | awk '{print $1}'")
  -- shorten hash
  unique_hash = string.sub(unique_hash, 1, 8)


  local journal_dir = ExpandHomePath("~/Documents/Notes/Archives/Chat/")
  local date = os.date("*t")
  local year = date.year
  local month = string.format("%02d", date.month)
  local day = string.format("%02d", date.day)
  local journal_path = journal_dir .. year .. "-" .. month .. "-" .. day .. "-" .. unique_hash .. ".md"

  -- Ensure the directory exists
  EnsureDirectoryExists(journal_dir)

  -- Check if we already have this buffer open
  local buf_name = vim.fn.expand(journal_path)
  local existing_bufnr = vim.fn.bufnr(buf_name)

  -- If the buffer exists, use it
  if existing_bufnr ~= -1 then
    current_chat_bufnr = existing_bufnr
    local win_id = vim.fn.win_findbuf(existing_bufnr)

    if #win_id > 0 then
      -- Buffer is displayed, focus on its window
      vim.api.nvim_set_current_win(win_id[1])
    else
      -- Buffer exists but not displayed, open in a split
      vim.cmd("vsplit")
      vim.cmd("buffer " .. existing_bufnr)
    end
  else
    -- Buffer doesn't exist, create it
    vim.cmd("vsplit " .. buf_name)
    vim.bo.filetype = 'markdown'
    current_chat_bufnr = vim.fn.bufnr(buf_name)
  end

  return current_chat_bufnr
end

-- Function to open the long-running todos file directly
function OpenLongRunningTodos()
  local todos_dir = ExpandHomePath("~/Documents/Notes/Projects/Todos/")
  local todos_path = todos_dir .. "todos.md"
  -- Ensure the directory exists
  EnsureDirectoryExists(todos_dir)
  OpenBuffer(todos_path)
end

-- Key mappings
vim.api.nvim_set_keymap('n', '<leader>td', ':lua OpenJournal("journal")<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>cg', ':lua OpenChat("chatbot")<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>lt', ':lua OpenLongRunningTodos()<CR>', { noremap = true })

-- Keymap in visual mode (x mode covers char, line, and block visual selections)
vim.keymap.set('x', '<leader>cp', function()
  -- 1. Get selection start and end positions in the buffer
  local _, srow, scol, _ = unpack(vim.fn.getpos("v")) -- visual start position (mark 'v')
  local _, erow, ecol, _ = unpack(vim.fn.getpos(".")) -- visual end position (cursor)
  local mode = vim.fn.mode()                          -- current visual mode: 'v', 'V', or Ctrl-V (shown as '\22')
  local lines = {}

  if mode == 'V' then
    -- Line-wise selection: get full lines from srow to erow
    if srow > erow then srow, erow = erow, srow end -- swap if selection is backwards
    lines = vim.api.nvim_buf_get_lines(0, srow - 1, erow, false)
  elseif mode == 'v' then
    -- Character-wise selection: use nvim_buf_get_text for exact range
    if srow < erow or (srow == erow and scol <= ecol) then
      lines = vim.api.nvim_buf_get_text(0, srow - 1, scol - 1, erow - 1, ecol, {})
    else
      -- If backwards selection, swap the positions
      lines = vim.api.nvim_buf_get_text(0, erow - 1, ecol - 1, srow - 1, scol, {})
    end
  elseif mode == '\22' then -- Visual block mode (Ctrl-V)
    if srow > erow then srow, erow = erow, srow end
    if scol > ecol then scol, ecol = ecol, scol end
    for l = srow, erow do
      local text = vim.api.nvim_buf_get_text(0, l - 1, scol - 1, l - 1, ecol, {})
      lines[#lines + 1] = text[1] or "" -- get_text returns a table of lines
    end
  end

  if #lines == 0 then return end -- nothing selected (should not happen in visual mode)

  -- 2. Determine file path relative to project root and selection line numbers
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then file = "[No Name]" end -- buffer has no file name
  -- Calculate relative path from Git root or current working directory
  local root = vim.fn.getcwd()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if git_root and git_root ~= "" and not git_root:match("fatal") then
    root = git_root
  end
  local rel_path = file
  if root ~= "" and file:find(root, 1, true) == 1 then
    rel_path = file:sub(#root + 2) -- strip the root path prefix and '/'
  end

  -- Line number info (use first and last selected line, 1-indexed)
  local first_line                  = math.min(srow, erow)
  local last_line                   = math.max(srow, erow)
  local line_info                   = (first_line == last_line)
      and tostring(first_line)
      or (tostring(first_line) .. "-" .. tostring(last_line))

  -- Language for markdown code fence (use file extension if available)
  local ext                         = vim.fn.fnamemodify(file, ":e") -- file extension
  local lang                        = (ext ~= "" and ext) or ""      -- default to empty if no extension

  -- Construct the snippet lines: "path:line(s)", code fence, code, end fence
  local snippet_lines               = {}
  snippet_lines[#snippet_lines + 1] = rel_path .. ":" .. line_info
  snippet_lines[#snippet_lines + 1] = "```" .. lang
  vim.list_extend(snippet_lines, lines) -- append all selected lines
  snippet_lines[#snippet_lines + 1] = "```"

  -- 3. Open (or switch to) chat buffer, append snippet, then return to original window
  local cur_win = vim.api.nvim_get_current_win() -- save current window

  -- Exit visual mode before switching buffers
  vim.cmd('normal! ' .. string.char(27))          -- ASCII 27 is ESC

  pcall(OpenChat)                                 -- open the chat buffer (existing function)
  local chat_buf = vim.api.nvim_get_current_buf() -- chat buffer (now current)

  -- Append lines at end of chat buffer
  vim.api.nvim_buf_set_lines(chat_buf, -1, -1, false, snippet_lines)

  -- Restore focus to the original window
  vim.api.nvim_set_current_win(cur_win)
  -- vim.cmd('normal! ' .. string.char(27))                                 -- reselect the visual area
end, { noremap = true, desc = "Copy selection to chat buffer" })

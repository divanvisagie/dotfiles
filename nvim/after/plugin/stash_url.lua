local function get_file()
  -- get git root directory
  local handle = io.popen("git rev-parse --show-toplevel")
  local result = handle:read("*a")
  handle:close()

  -- get the relative file path
  local git_root_dir = result:match("^.*/")
  local file_path = vim.fn.expand('%:p')
  local relative_file_path = file_path:sub(#git_root_dir+1)

  -- Remove the first folder from the relative file path
  local pos = relative_file_path:find("/")

  if pos then
    relative_file_path = relative_file_path:sub(pos+1)
  end

  return relative_file_path
end

local function get_remote()
  -- get the remote url
  local handle = io.popen("git config --get remote.origin.url")
  if handle == nil then
    return ""
  end
  local result = handle:read("*a")

  if result == "" then
    print("No remote found")
    return ""
  end
  handle:close()
  local ssh, user, domain, port, group, repo = result:match("(ssh://)([^@]+)@([^:]+):(%d+)/([^/]+)/([^/]+).git")

  local git_remote_url = ("https://%s/projects/%s/repos/%s/browse/"):format(domain, group:upper(), repo)

  return git_remote_url
end

-- Get the line number that our cursor is on when 
-- running the function
function get_line_number() 
  local line = vim.fn.line(".")
  return line
end

local function sturl()
  local line_number = get_line_number()
  local fp = get_file()
  local rp = get_remote()
  local path = rp .. fp

  -- Add line number to end of path
  path = path .. "#" .. line_number

  -- Copy URL to clipboard in MacOS
  os.execute("echo '" .. path .. "' | pbcopy")

  print("Copied to clipboard: " .. path)
end

local function furl()
  local path = get_file()

  -- Copy URL to clipboard in MacOS
  os.execute("echo '" .. path .. "' | pbcopy")

  print("Copied to clipboard: " .. path)
end

vim.keymap.set("n", "<leader>sturl", sturl, { desc = 'Copy [st]ash [url] to clipboard' }) -- Copy stash url to clipboard
vim.keymap.set("n", "<leader>furl", furl, { desc = 'Copy [f]ile [url] to clipboard' }) -- Copy file path to clipboard

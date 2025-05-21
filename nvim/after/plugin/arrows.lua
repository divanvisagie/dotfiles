local arrows = {}

local function rep(char, n) return string.rep(char, n) end

function arrows.arrow_right(len) return rep("─", len or 6) .. "▶" end

function arrows.arrow_left(len) return "◀" .. rep("─", len or 6) end

function arrows.arrow_twoside(len) return "◀" .. rep("─", len or 5) .. "▶" end

function arrows.arrow_down(height)
	height = height or 4
	local lines = {}
	for i = 1, height do lines[i] = "│" end
	table.insert(lines, "▼")
	return table.concat(lines, "\n")
end

function arrows.arrow_up(height)
	height = height or 4
	local lines = { "▲" }
	for i = 1, height do lines[i + 1] = "│" end
	return table.concat(lines, "\n")
end

-- Insert a horizontal arrow at cursor position in the current line
local function insert_horiz_arrow(text)
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local bufnr    = 0
	local line     = vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1] or ""
	local before   = line:sub(1, col)
	local after    = line:sub(col + 1)
	local new_line = before .. text .. after
	vim.api.nvim_buf_set_lines(bufnr, row - 1, row, false, { new_line })
	-- Move cursor to after the inserted arrow
	vim.api.nvim_win_set_cursor(0, { row, col + #text })
end

-- Insert a vertical arrow (down or up) with the arrowhead at cursor line/col
local function insert_vert_arrow(lines_arr)
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local bufnr = 0
	for i, text in ipairs(lines_arr) do
		-- Insert text at col in each line, padding as needed
		local edit_row = row - 1 + i - 1
		-- Get existing line or create empty
		local existing = vim.api.nvim_buf_get_lines(bufnr, edit_row, edit_row + 1, false)[1] or ""
		local before = existing:sub(1, col)
		local after = existing:sub(col + 1)
		local new_line = before .. text .. after
		vim.api.nvim_buf_set_lines(bufnr, edit_row, edit_row + 1, false, { new_line })
	end
	-- Move cursor to after the arrow head
	vim.api.nvim_win_set_cursor(0, { row + #lines_arr - 1, col + 1 })
end

-- Keymaps for inserting at cursor
vim.keymap.set('n', '<leader>ar', function() insert_horiz_arrow(arrows.arrow_right(6)) end,
	{ desc = "Insert → arrow at cursor" })
vim.keymap.set('n', '<leader>al', function() insert_horiz_arrow(arrows.arrow_left(6)) end,
	{ desc = "Insert ← arrow at cursor" })
vim.keymap.set('n', '<leader>ab', function() insert_horiz_arrow(arrows.arrow_twoside(5)) end,
	{ desc = "Insert ⇄ arrow at cursor" })

vim.keymap.set('n', '<leader>ad', function()
	local arr = {}
	for s in arrows.arrow_down(3):gmatch("[^\n]+") do table.insert(arr, s) end
	insert_vert_arrow(arr)
end, { desc = "Insert vertical ↓ arrow at cursor" })
vim.keymap.set('n', '<leader>au', function()
	local arr = {}
	for s in arrows.arrow_up(3):gmatch("[^\n]+") do table.insert(arr, s) end
	insert_vert_arrow(arr)
end, { desc = "Insert vertical ↑ arrow at cursor" })

return arrows

-- Utility for getting the current visual or linewise selection, as in your base
function GetSelectionInfo()
	local mode = vim.fn.mode()
	local _, srow, scol, _ = unpack(vim.fn.getpos("v"))
	local _, erow, ecol, _ = unpack(vim.fn.getpos("."))
	local lines = {}

	if mode == 'V' then
		if srow > erow then srow, erow = erow, srow end
		lines = vim.api.nvim_buf_get_lines(0, srow - 1, erow, false)
	elseif mode == 'v' then
		if srow < erow or (srow == erow and scol <= ecol) then
			lines = vim.api.nvim_buf_get_text(0, srow - 1, scol - 1, erow - 1, ecol, {})
		else
			lines = vim.api.nvim_buf_get_text(0, erow - 1, ecol - 1, srow - 1, scol, {})
		end
	elseif mode == '\22' then
		if srow > erow then srow, erow = erow, srow end
		if scol > ecol then scol, ecol = ecol, scol end
		for l = srow, erow do
			local text = vim.api.nvim_buf_get_text(0, l - 1, scol - 1, l - 1, ecol, {})
			lines[#lines + 1] = text[1] or ""
		end
	end
	return lines, { srow, scol, erow, ecol }, mode
end

function PipeSelectionThroughBoxes(style)
	local lines, sel, mode = GetSelectionInfo()
	local srow, scol, erow, ecol = unpack(sel)
	local text = table.concat(lines, "\n")
	local args = { "boxes" }
	-- Style mappings
	if style == "ansi-center" then
		vim.list_extend(args, { "-d", "ansi-heavy", "-a", "c" })
	elseif style == "info" then
		vim.list_extend(args, { "-d", "shell" })        -- or any style you consider informative
	elseif style == "warn" then
		vim.list_extend(args, { "-d", "f90-box", "-a", "c" }) -- or another as you see "warn"
	elseif style then
		vim.list_extend(args, vim.split(style, " "))
	end

	local out_lines = {}

	-- Use vim.system if available (NVIM >0.10), else fallback to vim.fn.systemlist
	local function handle_out(output)
		out_lines = vim.split(output, "\n", { plain = true })
		if mode == 'v' then
			vim.api.nvim_buf_set_text(0, srow - 1, scol - 1, erow - 1, ecol, out_lines)
		else
			vim.api.nvim_buf_set_lines(0, srow - 1, erow, false, out_lines)
		end
	end

	local cmd = { unpack(args) }
	if vim.system then
		vim.system(cmd, { stdin = text }, function(res)
			vim.schedule(function()
				local output = res.stdout or "No output"
				handle_out(output)
			end)
		end)
	else
		local output = vim.fn.system(table.concat(cmd, " "), text)
		handle_out(output)
	end
end

-- Keymaps (examples, pick or adjust as you wish)
vim.keymap.set('x', '<leader>bc', function() PipeSelectionThroughBoxes("ansi-center") end,
	{ desc = "Boxes ansi-heavy, centered" })
vim.keymap.set('x', '<leader>bi', function() PipeSelectionThroughBoxes("info") end, { desc = "Boxes info" })
vim.keymap.set('x', '<leader>bw', function() PipeSelectionThroughBoxes("warn") end, { desc = "Boxes warn" })

vim.keymap.set('n', '<leader>bc', function()
	vim.cmd('normal! V')
	PipeSelectionThroughBoxes("ansi-center")
end, { desc = "Boxes ansi-heavy, centered (line)" })
vim.keymap.set('n', '<leader>bi', function()
	vim.cmd('normal! V')
	PipeSelectionThroughBoxes("info")
end, { desc = "Boxes info (line)" })
vim.keymap.set('n', '<leader>bw', function()
	vim.cmd('normal! V')
	PipeSelectionThroughBoxes("warn")
end, { desc = "Boxes warn (line)" })

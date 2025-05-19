--- Returns:
---   lines (table of strings),
---   {srow, scol, erow, ecol} (indices, 1-based),
---   mode (string, 'v','V','\22'),
---   rel_path (string),
---   lang (string)
function CgipGetSelectionInfo()
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

	local file = vim.api.nvim_buf_get_name(0)
	local root = vim.fn.getcwd()
	local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	if git_root and git_root ~= "" and not git_root:match("fatal") then
		root = git_root
	end
	local rel_path = file
	if root ~= "" and file:find(root, 1, true) == 1 then
		rel_path = file:sub(#root + 2)
	end
	local ext = vim.fn.fnamemodify(file, ":e")
	local lang = (ext ~= "" and ext or "")

	return lines, { srow, scol, erow, ecol }, mode, rel_path, lang
end

function RunCgipOverSelection()
	local lines, sel, mode = CgipGetSelectionInfo()
	local srow, scol, erow, ecol = unpack(sel) -- ← unpack properly
	local text = table.concat(lines, "\n")

	vim.g.cgip_busy = true
	vim.cmd("redrawstatus")

	vim.system(
		{ "cgip",
			"'You are inside neovim, your output will replace the input text exactly, output only what is asked for, no extra formatting if replacing'" }, -- replace with your cgip command
		{ stdin = text },
		function(res)
			vim.schedule(function()
				vim.g.cgip_busy = false
				vim.cmd("redrawstatus")

				local output = res.stdout or "No output"
				local out_lines = vim.split(output, "\n", { plain = true })

				if mode == 'v' then -- character-wise visual
					-- nvim_buf_set_text(end row/col are *exclusive*)
					vim.api.nvim_buf_set_text(
						0,
						srow - 1, scol - 1,
						erow - 1, ecol,
						out_lines
					)
				else -- line-wise (V) or “current line”
					-- nvim_buf_set_lines(end row is *exclusive*)
					vim.api.nvim_buf_set_lines(
						0,
						srow - 1,
						erow,
						false,
						out_lines
					)
				end
			end)
		end
	)
end

vim.keymap.set('x', '<leader>C', RunCgipOverSelection, { desc = "Pipe selection through cgip" })
vim.keymap.set('n', '<leader>C', RunCgipOverSelection, { desc = "Pipe current line through cgip" })

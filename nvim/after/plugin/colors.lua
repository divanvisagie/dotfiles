function ColorMyPencils(color)
	color = color or "gruvbox"
	vim.cmd.colorscheme(color)
	-- Set background transparent
	vim.api.nvim_set_hl(0, "Normal",{ bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat",{ bg = "none" })
end

ColorMyPencils()

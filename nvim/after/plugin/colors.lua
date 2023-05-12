function Trans(color)
	-- Set background transparent
	vim.api.nvim_set_hl(0, "NormalFloat",{ bg = "none" })
	vim.api.nvim_set_hl(0, "Normal",{ bg = "none" })
end

function Dark()
    vim.o.background = "dark"
    color = color or "everforest"
	vim.cmd.colorscheme(color)
end

function Light()
    vim.o.background = "light"
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)
end

Light()

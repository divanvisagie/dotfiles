function ColorMyPencils(color)
    -- vim.o.background = "light"
	color = color or "rose-pine"
    -- color = color or "everforest"
    vim.o.background = "dark"
	vim.cmd.colorscheme(color)
	-- Set background transparent
	-- vim.api.nvim_set_hl(0, "NormalFloat",{ bg = "none" })
	-- vim.api.nvim_set_hl(0, "Normal",{ bg = "none" })
end

ColorMyPencils()

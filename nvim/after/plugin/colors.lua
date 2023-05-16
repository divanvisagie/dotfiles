function Trans(color)
	-- Set background transparent
	vim.api.nvim_set_hl(0, "NormalFloat",{ bg = "none" })
	vim.api.nvim_set_hl(0, "Normal",{ bg = "none" })
end

function Dark()
    vim.o.background = "dark"
	vim.cmd.colorscheme("everforest")
end

function Light()
    vim.o.background = "light"
	vim.cmd.colorscheme("rose-pine")
end

Dark()

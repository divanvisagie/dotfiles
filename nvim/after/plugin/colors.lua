function Trans(color)
	-- Set background transparent
	vim.api.nvim_set_hl(0, "NormalFloat",{ bg = "none" })
	vim.api.nvim_set_hl(0, "Normal",{ bg = "none" })
end

function Dark()
    vim.o.background = "dark"
	vim.cmd.colorscheme("everforest")
    Trans()
end

function Light()
    vim.o.background = "light"
	vim.cmd.colorscheme("rose-pine")
end

local function isDarkModeEnabled()
    local darkModeOutput = os.execute("defaults read -g AppleInterfaceStyle 2>/dev/null")
    return darkModeOutput == 0
end

if isDarkModeEnabled() then
    Dark()
else
    Light()
end

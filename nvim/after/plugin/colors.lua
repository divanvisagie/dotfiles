function Trans()
	-- Set background transparent
	vim.api.nvim_set_hl(0, "NormalFloat",{ bg = "none" })
	vim.api.nvim_set_hl(0, "Normal",{ bg = "none" })
end

-- vim.cmd.colorscheme("catpuccin")
function Dark()
    -- vim.cmd.colorscheme("everforest")
    -- vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_background = "medium"
    vim.cmd.colorscheme("gruvbox-material")
    vim.o.background = "dark"
end

function Light()
    vim.cmd.colorscheme("rose-pine")
    vim.o.background = "light"
end


local auto_dark_mode = require('auto-dark-mode')
auto_dark_mode.setup({
	update_interval = 1000,
	set_dark_mode = function()
		-- vim.api.nvim_set_option('background', 'dark')
		-- vim.cmd('colorscheme gruvbox')
        Dark()
	end,
	set_light_mode = function()
		-- vim.api.nvim_set_option('background', 'light')
		-- vim.cmd('colorscheme gruvbox')
        Light()
	end,
})

-- Disable italics on certain identifiers
local hl_groups = {
  "Comment", "Function", "Identifier", "Statement", "Type", "Keyword", "Conditional",
  "Repeat", "Operator", "PreProc", "Include", "Define", "Macro", "PreCondit", "StorageClass",
  "Structure", "Typedef", "Tag", "Label", "Special", "SpecialChar", "Delimiter", "SpecialComment",
  "Debug", "Underlined", "Ignore", "Error", "Todo"
}

for _, group in ipairs(hl_groups) do
  vim.cmd(string.format("highlight %s cterm=NONE gui=NONE", group))
end

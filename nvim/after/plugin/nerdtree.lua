-- NERDTree toggle mapping
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', {noremap=true, silent=true})

-- Mapping to find the active file in NERDTree
vim.g.NERDTreeShowHidden = 1

local wk = require("which-key")
local mappings = {
	n = {
		name = "NERDTree",
		t = { "<cmd>NERDTreeToggle<CR>", "Toggle" },
		f = { "<cmd>NERDTreeFind<CR>", "Find in tree" },
	},
	h = {
		a = {
		    f = { "<cmd>NERDTreeFind<CR>", "Find in tree" },
		}
	}
}
local opts = { prefix = "<leader>" }
wk.register(mappings, opts)


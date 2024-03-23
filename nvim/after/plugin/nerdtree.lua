-- NERDTree toggle mapping
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', {noremap=true, silent=true})

-- Mapping to find the active file in NERDTree
vim.api.nvim_set_keymap('n', '<leader>haf', ':NERDTreeFind<CR>', {noremap = true, silent = true})
vim.g.NERDTreeShowHidden = 1

local wk = require("which-key")
local mappings = {
	n = {
		name = "NERDTree",
		t = { "<cmd>NERDTreeToggle<CR>", "Toggle" },
		f = { "<cmd>NERDTreeFind<CR>", "Find" },
	},
}
local opts = { prefix = "<leader>" }
wk.register(mappings, opts)

-- Require which-key
local wk = require("which-key")

-- Define the mappings
local mappings = {
  g = {
    name = "Git",
    g = { "<cmd>G<CR>", "Status" },
    s = { "<cmd>Gvdiffsplit<CR>", "Split vertical diff" },
    b = { "<cmd>Git blame<CR>", "Blame" },
  },
}

-- Define the options
local opts = { prefix = "<leader>" }

-- Register the mappings
wk.register(mappings, opts)

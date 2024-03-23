require('gitblame').setup {
     --Note how the `gitblame_` prefix is omitted in `setup`
    enabled = false,
}


local wk = require("which-key")
local mappings = {
    g = {
        name = "Git",
        b = { "<cmd>Git blame<CR>", "Blame" },
    },
}
local opts = { prefix = "<leader>" }
wk.register(mappings, opts)

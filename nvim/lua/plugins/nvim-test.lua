return {
  "klen/nvim-test",
  config = function()
    local test = require("nvim-test")
    local cwd = vim.fn.getcwd()
    -- detect Deno by presence of deno.json
    local is_deno = vim.fn.glob(cwd .. "/deno.json") ~= ""

    -- reuse the Jest adapter for BOTH Jest and Deno
    require("nvim-test.runners.jest"):setup {
      -- if it's a Deno project, run deno test; otherwise run your local jest
      command = is_deno and "deno" or "~/node_modules/.bin/jest",
      args    = is_deno and { "test" } or { "--collectCoverage=false" },
      -- (you can tweak file_pattern or find_files here if needed)
    }

    test.setup {
      -- point all the JS/TS fts at our single adapter
      runners = {
        javascript      = "nvim-test.runners.jest",
        javascriptreact = "nvim-test.runners.jest",
        typescript      = "nvim-test.runners.jest",
        typescriptreact = "nvim-test.runners.jest",
      },
      -- keep whatever other defaults you like:
      -- run = true, term = "terminal", termOpts = { … }, silent = false, etc.
    }

    -- your keymaps
    vim.api.nvim_set_keymap("n", "<leader>tf", ":TestFile<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>tn", ":TestNearest<CR>", { noremap = true, silent = true })
  end,
}

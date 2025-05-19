return {
  "klen/nvim-test",
  config = function()
    local test = require("nvim-test")
    local cwd = vim.fn.getcwd()
    local is_deno = vim.fn.filereadable(cwd .. "/deno.json") == 1

    require("nvim-test.runners.jest"):setup {
      command = is_deno and "deno" or "jest",
      args = is_deno
          and { "test", "--quiet", "--allow-all" } -- or fine-tune: "--allow-read", etc.
          or { "--collectCoverage=false" },
      file_pattern = "\\v(test|spec)\\.ts$",
    }

    test.setup {
      termOpts = {
        width = 63,
      },
      runners = {
        typescript = "nvim-test.runners.jest",
        javascript = "nvim-test.runners.jest",
      },
    }

    vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>", { noremap = true, silent = true })
  end
}

-- lsp.lua
--

-- 2. Define on_attach function for LSP keybindings
local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }

  -- Keybindings for LSP functions
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>ref", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>fd", function() vim.lsp.buf.format({ async = true }) end, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

  -- Create user command for formatting
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format({ async = true })
  end, {})
end

-- 3. Setup capabilities for nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- 4. Setup nvim-cmp for autocompletion
local cmp = require("cmp")
cmp.setup({
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  },
  sources = {
    { name = "nvim_lsp" },
    -- Add other sources if needed
  },
})

-- 5. Configure LSP servers
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

-- Deno
lspconfig.denols.setup({
  root_dir = util.root_pattern("deno.json", "deno.jsonc"),
  init_options = {
    lint = true,
    unstable = true,
  },
  on_attach = on_attach,
  capabilities = capabilities,
})

-- VTSLS
lspconfig.vtsls.setup({
  root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
  settings = {
    typescript = {
      tsserver = {
        maxTsServerMemory = 6 * 1024,
      },
    },
  },
  single_file_support = false,
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Rust Analyzer
lspconfig.rust_analyzer.setup({
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
})

-- 6. Optional: Setup Telescope keybinding for document symbols
vim.keymap.set("n", "<leader>ds", function()
  require("telescope.builtin").lsp_document_symbols()
end, { desc = "[D]ocument [S]ymbols" })

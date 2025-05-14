return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "folke/neodev.nvim",
    "nvim-telescope/telescope.nvim",
    "stevearc/conform.nvim",
  },
  config = function()
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
      },
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>ref", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, opts)
      vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format({ async = true })
      end, {})
    end

    local util = require("lspconfig.util")
    local lspconfig = require("lspconfig")

    lspconfig.lua_ls.setup({
      cmd = { "lua-language-server" },
      filetypes = { "lua" },
      root_markers = { ".git", "init.lua" },
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } }
        }
      },
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig.tsserver.setup({
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

    lspconfig.denols.setup({
      root_dir = util.root_pattern("deno.json", "deno.jsonc"),
      init_options = {
        lint = true,
        unstable = true,
      },
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig.rust_analyzer.setup({
      cmd = { "rust-analyzer" },
      filetypes = { "rust" },
      root_markers = { "Cargo.toml" },
      settings = {
        ["rust-analyzer"] = { cargo = { allFeatures = true } }
      },
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig.markdown_oxide.setup({
      cmd = { "markdown-oxide", "--lsp" }, -- Adjust the command if needed. '--lsp' enables LSP mode
      filetypes = { "markdown" },
      root_dir = function(fname)
        --  Define how to find the project root directory (optional).
        --  This example looks for a .git directory or a Cargo.toml file.
        return require("lspconfig.util").root_pattern(".git", "Cargo.toml")(fname) or vim.fn.getcwd()
      end,
      on_attach = on_attach,       -- Use the same on_attach function you defined
      capabilities = capabilities, -- Use the same capabilities
    })


    vim.keymap.set("n", "<leader>ds", function()
      require("telescope.builtin").lsp_document_symbols()
    end, { desc = "[D]ocument [S]ymbols" })

    -- Conform.nvim setup for Prettier and ESLint
    require("conform").setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
      },
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      },
    })
    vim.keymap.set("n", "<leader>cf", function()
      require("conform").format({ async = true, lsp_fallback = true })
    end, { desc = "[C]onform [F]ormat" })
    vim.keymap.set("n", "<leader>fd", function()
      require("conform").format({ async = true, lsp_fallback = true })
    end, { desc = "[F]ormat [D]ocument (Conform)" })
  end
}

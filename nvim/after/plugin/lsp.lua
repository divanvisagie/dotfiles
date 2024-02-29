-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
    -- add any options here, or leave empty to use the default settings
    library = { plugins = { "nvim-dap-ui" }, types = true },
})

local nvim_lsp = require("lspconfig")

nvim_lsp.tsserver.setup {
  init_options = {
    maxTsServerMemory = 8192,
    -- disableAutomaticTypingAcquisition = true,
  },
  settings = {
    preferences = {
      includeCompletionsForModuleExports = false,
      includeInlayVariableTypeHintsWhenTypeMatchesName = true,
      includeInlayFunctionParameterTypeHints = true, -- Enable type inlay hints for function parameters
    },
  },
}

local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'rust_analyzer',
    'eslint',
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

-- Only apply for lsps
lsp.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "<leader>gd", function()
        vim.lsp.buf.definition()
        vim.cmd("vsplit")
    end, opts)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end,
        { buffer = bufnr, remap = false, desc = '[g]o to [d]efinition' }) -- Go to definition
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end,
        { buffer = bufnr, remap = false, desc = 'Code action' })
    vim.keymap.set("n", "<leader>ref", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>fd", function() vim.lsp.buf.format() end,
        { buffer = bufnr, remap = false, desc = '[F]ormat [D]ocument' })
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, {})
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)
lsp.setup()

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- Packer can manage itself

    use 'theprimeagen/refactoring.nvim'
    use 'theprimeagen/harpoon'

    use 'preservim/nerdtree'

    use 'simrat39/rust-tools.nvim'
    use 'nvim-tree/nvim-web-devicons'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    -- Display errors better
    use 'folke/trouble.nvim'

    -- copilot
    use 'zbirenbaum/copilot.lua'

    -- debug adapter protocol
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'leoluz/nvim-dap-go'
    -- run tests
    use {
        "klen/nvim-test"
    }
    use 'nvim-lualine/lualine.nvim' -- Better status line

    use 'anuvyklack/pretty-fold.nvim' -- Better code folding
    use 'nmac427/guess-indent.nvim' -- guess indentation

    -- Color Schemes
    use({ 'rose-pine/neovim', as = 'rose-pine' })
    use 'sainnhe/everforest'

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' }) -- Better Syntax Highlighting

    use 'mbbill/undotree'  -- A history of your undos
    use { 'numToStr/Comment.nvim' } -- Easier code comments

    -- Shows shortcut key help when initiating a command
    use { "folke/which-key.nvim" }

    -- helpers for neovim lua
    use { "folke/neodev.nvim" }

    -- lsp
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {
                'neovim/nvim-lspconfig',
                opts = {
                    autoformat = true,
                    servers = {
                        jsonls = {},
                        tsserver = {
                            init_options = {
                                -- support large TS projects
                                maxTsServerMemory = 8192,
                                disableAutomaticTypingAcquisition = true,
                            },
                            preferences = {
                                includeCompletionsForModuleExports = false,
                                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                            },
                        },
                        eslint = {},
                    },
                }
            },
            {
            -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' }, -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' }, -- Required
        }
    }
end)

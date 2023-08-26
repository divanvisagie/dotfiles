local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use("theprimeagen/refactoring.nvim")
    use("theprimeagen/harpoon")

    use "preservim/nerdtree"
    use 'simrat39/rust-tools.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    -- Display errors better 
    use { "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    }
    -- copilot 
    use {
        "zbirenbaum/copilot.lua",
    }
    -- debug adapter protocol
    use 'mfussenegger/nvim-dap'
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
    use 'leoluz/nvim-dap-go'
    -- run tests
    use {
        "klen/nvim-test",
        config = function()
            require('nvim-test').setup()
        end
    }
    -- Status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use{ 'anuvyklack/pretty-fold.nvim',
       config = function()
          require('pretty-fold').setup()
       end
    }
    -- guess indentation
    use {
        'nmac427/guess-indent.nvim',
        config = function() require('guess-indent').setup {} end,
    }
    -- ColorScheme
    -- If you are using Packer
    use { "ellisonleao/gruvbox.nvim" }
    use({ 'rose-pine/neovim', as = 'rose-pine' })
    use { "sainnhe/everforest" }
    -- Better Syntax Highlighting
    use ( 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
    -- A history of your undos
    use ( 'mbbill/undotree' )
    -- File tree
    use ( 'nvim-tree/nvim-web-devicons' )
    -- Comments
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    -- Shows shortcut key help when initiating a command
    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig',
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
        {                                      -- Optional
        'williamboman/mason.nvim',
        run = function()
            pcall(vim.cmd, 'MasonUpdate')
        end,
    },
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},     -- Required
    {'hrsh7th/cmp-nvim-lsp'}, -- Required
    {'L3MON4D3/LuaSnip'},     -- Required
  }
}

end)

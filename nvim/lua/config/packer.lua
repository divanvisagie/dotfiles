vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
  -- ColorScheme
-- If you are using Packer
  use { "ellisonleao/gruvbox.nvim" }
  -- Better Syntax Highlighting
  use ( 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
  -- A history of your undos
  use ( 'mbbill/undotree' )
  -- File tree
--  use ( 'nvim-tree/nvim-tree.lua' )
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
      },             -- Required
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

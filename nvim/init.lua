require("config")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({

    -- Navigation and refactoring
    'theprimeagen/refactoring.nvim',
    'theprimeagen/harpoon',

    -- Translate typescript errors to something easier to parse for grug brain
    'dmmulroy/ts-error-translator.nvim', 

    'preservim/nerdtree', 
	{
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'folke/trouble.nvim', -- Display errors better
        tag = 'v2.10.0'
    },
    {
        "mason-org/mason.nvim"
    },
    {
      "neovim/nvim-lspconfig", -- Core LSP support
      dependencies = {
        "hrsh7th/nvim-cmp",          -- Autocompletion engine
        "hrsh7th/cmp-nvim-lsp",      -- LSP source for nvim-cmp
        "folke/neodev.nvim",         -- Better Lua support for Neovim config
        "nvim-telescope/telescope.nvim", -- Optional, for <leader>ds
      },
    },

    -- GitHub Copilot
    'zbirenbaum/copilot.lua',
 	
	-- Tests
    'klen/nvim-test',              -- Run tests

    'nvim-lualine/lualine.nvim',   -- Better status line

    {
      "Konfekt/FastFold",
      config = function()
        -- Optional: any FastFold-specific config
      end,
      lazy = false,
    },
    'nmac427/guess-indent.nvim',   -- Guess indentation
 	
	-- Color Schemes
    'sainnhe/gruvbox-material',
    'chriskempson/vim-tomorrow-theme',


    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"  -- This replaces the 'do' hook from Vim-Plug
    },
    {
      "nvim-treesitter/nvim-treesitter-context",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      config = function()
        require("treesitter-context").setup {
          enable = true,  -- Enable the plugin
          max_lines = 3,  -- Show up to 3 lines of context
          trim_scope = "outer",  -- Trim long context blocks
          mode = "cursor",  -- Show context at cursor (can be "topline" too)
        }
      end
    },

    -- Allow you to to comment stuff out with a shortcut
    'numToStr/Comment.nvim',     

    -- undo history visualiser
    'mbbill/undotree',                                         -- A history of your undos

    -- Shows shortcut key help when initiating a command
    'folke/which-key.nvim',

    'folke/neodev.nvim', -- helpers for neovim lua

    -- Useful status updates for LSP
    { 'j-hui/fidget.nvim', tag = 'legacy' },

	-- Git diff
	'tpope/vim-fugitive',

    -- Thing trouble keeps complaining about
	'nvim-tree/nvim-web-devicons',

    -- Hex editing
    { 'RaafatTurki/hex.nvim' },

    -- React automatically to dark mode changes
    'f-person/auto-dark-mode.nvim',
    -- lazy.nvim
    {
      "folke/snacks.nvim",
      ---@type snacks.Config
      opts = {
        image = {
          -- your image configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      }
    }

})



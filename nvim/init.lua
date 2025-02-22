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

    -- GitHub Copilot
    'zbirenbaum/copilot.lua',
 	
	-- debug adapter protocol
    'mfussenegger/nvim-dap',
    'theHamsta/nvim-dap-virtual-text',

	-- Tests
    'klen/nvim-test',              -- Run tests

    'nvim-lualine/lualine.nvim',   -- Better status line

    'anuvyklack/pretty-fold.nvim', -- Better code folding
    'nmac427/guess-indent.nvim',   -- Guess indentation
 	
	-- Color Schemes
    'rose-pine/neovim',
    'sainnhe/gruvbox-material',

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

    -- LSP stuff
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
          'neovim/nvim-lspconfig',
          {
            'williamboman/mason.nvim',
            build = function() pcall(vim.cmd, 'MasonUpdate') end,
          },
          'williamboman/mason-lspconfig.nvim', -- Optional
          'hrsh7th/nvim-cmp',     -- Required for autocompletion
          'hrsh7th/cmp-nvim-lsp', -- Required for LSP completion source
          'L3MON4D3/LuaSnip',     -- Required for snippets
          'Feel-ix-343/markdown-oxide',
        }
    },
	-- Git diff
	'tpope/vim-fugitive',

    -- Thing trouble keeps complaining about
	'nvim-tree/nvim-web-devicons',

    -- Hex editing
    { 'RaafatTurki/hex.nvim' },

    -- React automatically to dark mode changes
    'f-person/auto-dark-mode.nvim'
})



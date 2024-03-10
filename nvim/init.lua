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
    'theprimeagen/refactoring.nvim',
    'theprimeagen/harpoon',
    'dmmulroy/ts-error-translator.nvim',

    'preservim/nerdtree', 
	{
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    'folke/trouble.nvim', -- Display errors better
    'zbirenbaum/copilot.lua',
 	
	-- debug adapter protocol
    'mfussenegger/nvim-dap',
    'theHamsta/nvim-dap-virtual-text',

	-- tests
    'klen/nvim-test',              -- run tests

    'nvim-lualine/lualine.nvim',   -- Better status line

    'anuvyklack/pretty-fold.nvim', -- Better code folding
    'nmac427/guess-indent.nvim',   -- guess indentation
 	
	-- Color Schemes
    'rose-pine/neovim',
    'sainnhe/everforest',
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"  -- This replaces the 'do' hook from Vim-Plug
    },

    -- Comments
    'numToStr/Comment.nvim',     

    -- undo history visualiser
    'mbbill/undotree',                                         -- A history of your undos


    -- Shows shortcut key help when initiating a command
    'folke/which-key.nvim',

    'folke/neodev.nvim', -- helpers for neovim lua

    -- Useful status updates for LSP
    { 'j-hui/fidget.nvim', tag = 'legacy' },
    
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
        }
      },
     -- Git blame
    'f-person/git-blame.nvim',
    'brooth/far.vim',

    -- Language specific tools
   'simrat39/rust-tools.nvim',
  'leoluz/nvim-dap-go',
  {
    "mxsdev/nvim-dap-vscode-js",
    lazy = true  -- `module` in Packer is equivalent to making it lazy-loaded in Lazy.nvim
    -- keys = { "<Plug>(your-custom-key-binding-here)" }  -- Replace with an actual key binding if needed
  },
  {
    "microsoft/vscode-js-debug",
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
    lazy = true  -- Set to lazy load, but consider specifying conditions for loading, similar to `opt` in Packer
  }
})



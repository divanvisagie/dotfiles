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

-- ensure_packer()
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- Packer can manage itself

    use 'theprimeagen/refactoring.nvim'
    use 'theprimeagen/harpoon'

    use 'preservim/nerdtree'

    use 'nvim-tree/nvim-web-devicons'

    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use 'folke/trouble.nvim' -- Display errors better

    use 'zbirenbaum/copilot.lua'

    -- debug adapter protocol
    use 'mfussenegger/nvim-dap'
    use 'theHamsta/nvim-dap-virtual-text'

    use 'klen/nvim-test'              -- run tests

    use 'nvim-lualine/lualine.nvim'   -- Better status line

    use 'anuvyklack/pretty-fold.nvim' -- Better code folding
    use 'nmac427/guess-indent.nvim'   -- guess indentation

    -- Color Schemes
    use 'rose-pine/neovim'
    use 'sainnhe/everforest'

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' }) -- Better Syntax Highlighting

    use 'mbbill/undotree'                                         -- A history of your undos
    use 'numToStr/Comment.nvim'                                   -- Easier code comments

    -- Shows shortcut key help when initiating a command
    use 'folke/which-key.nvim'

    use 'folke/neodev.nvim' -- helpers for neovim lua

    -- Useful status updates for LSP
    use { 'j-hui/fidget.nvim', tag = 'legacy' }

    -- LSP Zero setup
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {
                'neovim/nvim-lspconfig',
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
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    }

    -- Git blame
    use 'f-person/git-blame.nvim'
    use 'brooth/far.vim'

    -- Language specific tools
    use 'simrat39/rust-tools.nvim'
    use 'leoluz/nvim-dap-go'
    use { "mxsdev/nvim-dap-vscode-js", module = { "dap-vscode-js" } }
    use {
      "microsoft/vscode-js-debug",
      opt = true,
      run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out" 
    }
end)

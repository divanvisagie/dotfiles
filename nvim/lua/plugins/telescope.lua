return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require('telescope').setup()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', function()
      builtin.find_files({
        find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/*' },
      })
    end, { desc = '[F]ind [F]iles' })
    vim.keymap.set('n', '<D-p>', function() -- Another Zed / Vscode inspired shortcut
      builtin.find_files({
        find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/*' },
      })
    end, { desc = '[F]ind [F]iles' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[G]it Files' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    -- search lsp document symbols
    vim.keymap.set('n', '<leader>so', function()
      builtin.lsp_document_symbols()
    end, { desc = '[S]earch [D]ocument Symbols' })
    -- search lsp document symbols with Cmd-Shift-O (Zed mapping)
    vim.keymap.set('n', '<D-O>', function()
      builtin.lsp_document_symbols()
    end, { desc = '[S]earch [D]ocument Symbols (Cmd-Shift-O)' })
    vim.keymap.set('n', '<leader>fs', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end, { desc = '[F]ind grep [S]tring' })
  end
}

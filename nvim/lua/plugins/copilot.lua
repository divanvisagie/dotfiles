return {
  "zbirenbaum/copilot.lua",
  config = function()
    require('copilot').setup({
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<C-x>"
        },
        layout = {
          position = "bottom",
          ratio = 0.4
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = false,
        debounce = 75,
        keymap = {
          accept = "<C-a>",
          accept_word = false,
          accept_line = false,
          next = "<C-s>",
          prev = "<M-[>",
          dismiss = "<C-u>",
        },
      },
      filetypes = {
        yaml = true,
        go = true,
        markdown = true,
        help = false,
        gitcommit = true,
        gitrebase = true,
        lua = true,
        ["."] = false,
      },
      copilot_node_command = 'node',
      server_opts_overrides = {},
    })
  end
} 

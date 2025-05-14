return {
  "f-person/auto-dark-mode.nvim",
  dependencies = { 
    "chriskempson/vim-tomorrow-theme",
    "sainnhe/gruvbox-material"
  },
  config = function()
    function Dark()
      vim.g.gruvbox_material_background = "medium"
      vim.cmd.colorscheme("gruvbox-material")
      vim.o.background = "dark"
    end

    function Light()
      vim.cmd.colorscheme("tomorrow")
      vim.o.background = "light"
      vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
      vim.cmd("hi NormalNC guibg=NONE ctermbg=NONE")
    end

    function IsDarkMode()
      local handle = io.popen("dm -c")
      local darkModeOutput = handle:read("*a")
      handle:close()
      return darkModeOutput:find("true") ~= nil
    end

    if IsDarkMode() then
      Dark()
    else
      Light()
    end

    require('auto-dark-mode').setup({
      update_interval = 1000,
      set_dark_mode = function()
        Dark()
      end,
      set_light_mode = function()
        Light()
      end,
    })

    local hl_groups = {
      "Comment", "Function", "Identifier", "Statement", "Type", "Keyword", "Conditional",
      "Repeat", "Operator", "PreProc", "Include", "Define", "Macro", "PreCondit", "StorageClass",
      "Structure", "Typedef", "Tag", "Label", "Special", "SpecialChar", "Delimiter", "SpecialComment",
      "Debug", "Underlined", "Ignore", "Error", "Todo"
    }
    for _, group in ipairs(hl_groups) do
      vim.cmd(string.format("highlight %s cterm=NONE gui=NONE", group))
    end
  end
} 

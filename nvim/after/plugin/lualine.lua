local function relative_path()
  return vim.fn.expand('%')
end

-- Function to get a highlight group's attribute (foreground/background color)
local function get_hl_attr(group, attr)
  local hl = vim.api.nvim_get_hl_by_name(group, true)
  return hl[attr] and string.format("#%06x", hl[attr]) or nil
end

-- Function to get the background color of a group
local function get_bg_color(group)
  return get_hl_attr(group, 'background')
end

require('lualine').setup {
  options = {
    icons_enabled = false,
    global_status = true,
    theme = 'auto',
    component_separators = { left = '│', right = '│'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {
        -- ignore nerdtree
        'nerdtree',
      },
    },
    ignore_focus = {},
    always_divide_middle = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 3000,
    },
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'diff', 'diagnostics'},
    lualine_c = { relative_path	},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { relative_path },
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
}


-- ~/.dotfiles/wezterm/my_theme.lua
return {
  -- Tab bar color
  tab_bar = {
    -- The color of the inactive tab bar edge/divider
    inactive_tab_edge = '#32302f', -- Inactive tab edge
  },

  -- Primary colors
  foreground = "#d4be98", -- Primary foreground
  background = "#282828", -- Primary background

  -- Cursor colors
  cursor_bg = "#d4be98", -- Cursor background (matching foreground)
  cursor_border = "#d4be98", -- Cursor border (matching foreground)
  cursor_fg = "#1d2021", -- Cursor foreground (matching background)

  -- Selection colors
  selection_bg = "#32302f", -- Selection background (same as bright black)
  selection_fg = "#d4be98", -- Selection foreground (matching foreground)

  -- ANSI (normal) colors
  ansi = {
    "#32302f", -- Black
    "#ea6962", -- Red
    "#a9b665", -- Green
    "#d8a657", -- Yellow
    "#7daea3", -- Blue
    "#d3869b", -- Magenta
    "#89b482", -- Cyan
    "#d4be98", -- White
  },

  -- Bright colors (same as normal colors)
  brights = {
    "#32302f", -- Bright Black
    "#ea6962", -- Bright Red
    "#a9b665", -- Bright Green
    "#d8a657", -- Bright Yellow
    "#7daea3", -- Bright Blue
    "#d3869b", -- Bright Magenta
    "#89b482", -- Bright Cyan
    "#d4be98", -- Bright White
  },
}

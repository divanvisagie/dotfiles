-- ~/.wezterm/my_theme.lua
return {
  -- Tab bar color
  tab_bar = {
    -- The color of the inactive tab bar edge/divider
    inactive_tab_edge = '#575757', -- Inactive tab edge
  },

  -- Primary colors
  foreground = "#575279", -- Primary foreground
  background = "#faf4ed", -- Primary background

  -- Cursor colors
  cursor_bg = "#cecacd", -- Cursor background
  cursor_border = "#cecacd", -- Cursor border
  cursor_fg = "#575279", -- Cursor foreground (text)

  -- Selection colors
  selection_bg = "#dfdad9", -- Selection background
  selection_fg = "#575279", -- Selection foreground (text)

  -- ANSI (normal) colors
  ansi = {
    "#f2e9e1", -- Black
    "#b4637a", -- Red
    "#286983", -- Green
    "#ea9d34", -- Yellow
    "#56949f", -- Blue
    "#907aa9", -- Magenta
    "#d7827e", -- Cyan
    "#575279", -- White
  },

  -- Bright colors
  brights = {
    "#9893a5", -- Bright Black
    "#b4637a", -- Bright Red
    "#286983", -- Bright Green
    "#ea9d34", -- Bright Yellow
    "#56949f", -- Bright Blue
    "#907aa9", -- Bright Magenta
    "#d7827e", -- Bright Cyan
    "#575279", -- Bright White
  },
}

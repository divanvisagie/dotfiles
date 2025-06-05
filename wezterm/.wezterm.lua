-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- Dynamically get the home directory
local home = os.getenv("HOME")
package.path = package.path .. ';' .. home .. '/.dotfiles/wezterm/theme/?.lua' -- Add path to imports

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Set no window buttons
config.use_fancy_tab_bar = false

-- Only show bar if there is more than one tab
config.hide_tab_bar_if_only_one_tab = true

config.window_frame = {
  font = wezterm.font { family = 'Ubuntu', weight = 'Bold' },

  -- Default to 10.0 on Windows but 12.0 on other systems
  font_size = 14.0,
}

-- Don't pad the window
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}


config.inactive_pane_hsb = {
  saturation = 1,
  brightness = 1,
}

config.bold_brightens_ansi_colors = false

-- Set font rules to disable bolding and italics
-- config.font_rules = {
--   {
--     italic = true,                                              -- Matcher
--      font = wezterm.font("MesloLGS NF", { weight = "Regular" }), -- Setter
--   },
-- }

-- Function to choose a color scheme based on appearance
local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "Gruvbox Material (Gogh)"
  else
    return "Builtin Tango Light"
  end
end

-- Function to select theme based on appearance
local function get_theme(appearance)
  if appearance:find("Dark") then
    return require 'gruvboxdark'
  else
    return require 'rosepinedawn'
  end
end

--config.font = wezterm.font("MesloLGS NF")
if wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
  config.font_size = 14.0
  config.window_decorations = "NONE"
else
  config.font_size = 17.0
  config.window_decorations = "RESIZE"
end

wezterm.on('window-config-reloaded', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  local appearance = window:get_appearance()
  local scheme = scheme_for_appearance(appearance)
  local override_theme = get_theme(appearance)

  overrides.color_scheme = scheme
  -- overrides.colors = override_theme
  window:set_config_overrides(overrides)
end)

function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  local active_pane = tab_info.active_pane
  return active_pane.title
end

local function get_zoomed_indicator(pane)
  if pane.is_zoomed then
    return '*Z'
  else
    return ''
  end
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local pane = tab.active_pane
    -- local title = tab.tab_index.. ': ' .. tab.active_pane.title
    local title = tab_title(tab)

    local color = '#32302f'
    local fgcolor = '#777777'

    -- if tab.is_active then
    --   -- We detect dark mode by detecting the theme
    --   if config.color_scheme == 'rose-pine-dawn' then
    --     color = '#faf4ed'
    --     fgcolor = '#32302f'
    --   else
    --     color = '#282828'
    --     fgcolor = '#928374'
    --   end
    -- end
    local zoomed_indicator = get_zoomed_indicator(pane)
    return {
      { Background = { Color = color } },
      { Foreground = { Color = fgcolor } },
      { Text = ' ' .. tab.tab_index + 1 .. ' │ ' .. title .. ' │' .. zoomed_indicator },
    }
  end
)

-- Set the key bind to move right one split as alt+ctrl+l
config.keys = {
  { key = "l",  mods = "CTRL|ALT",   action = wezterm.action { ActivatePaneDirection = "Right" } },
  { key = "h",  mods = "CTRL|ALT",   action = wezterm.action { ActivatePaneDirection = "Left" } },
  { key = "j",  mods = "CTRL|ALT",   action = wezterm.action { ActivatePaneDirection = "Down" } },
  { key = "k",  mods = "CTRL|ALT",   action = wezterm.action { ActivatePaneDirection = "Up" } },
  -- Set ctrl +t to create a new tab
  { key = "t",  mods = "CTRL|SHIFT", action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
  -- close the tab with ctrl shift w
  { key = "w",  mods = "CTRL|SHIFT", action = wezterm.action { CloseCurrentTab = { confirm = true } } },

  -- Split Pane
  { key = "%",  mods = "CTRL|SHIFT", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
  { key = "\"", mods = "CTRL|SHIFT", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },

  -- Resize split
  { key = "l",  mods = "CTRL|SHIFT", action = wezterm.action { AdjustPaneSize = { 'Right', 2 } } },
  { key = "h",  mods = "CTRL|SHIFT", action = wezterm.action { AdjustPaneSize = { 'Left', 2 } } },
  { key = "j",  mods = "CTRL|SHIFT", action = wezterm.action { AdjustPaneSize = { 'Down', 2 } } },
  { key = "k",  mods = "CTRL|SHIFT", action = wezterm.action { AdjustPaneSize = { 'Up', 2 } } },

  -- Switch tabs with ctrl + number
  -- { key = "1",  mods = "CTRL",       action = wezterm.action { ActivateTab = 0 } },
  -- { key = "2",  mods = "CTRL",       action = wezterm.action { ActivateTab = 1 } },
  -- { key = "3",  mods = "CTRL",       action = wezterm.action { ActivateTab = 2 } },
  -- { key = "4",  mods = "CTRL",       action = wezterm.action { ActivateTab = 3 } },
  -- { key = "5",  mods = "CTRL",       action = wezterm.action { ActivateTab = 4 } },
  -- { key = "6",  mods = "CTRL",       action = wezterm.action { ActivateTab = 5 } },
  -- { key = "7",  mods = "CTRL",       action = wezterm.action { ActivateTab = 6 } },
  -- { key = "8",  mods = "CTRL",       action = wezterm.action { ActivateTab = 7 } },
  -- { key = "9",  mods = "CTRL",       action = wezterm.action { ActivateTab = 8 } },
}

-- We have to return the config
return config

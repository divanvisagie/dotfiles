-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- set no window buttons
config.window_decorations = "RESIZE"

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'rose-pine-dawn'
-- config.color_scheme = 'Gruvbox Material (Gogh)'

-- Function to choose a color scheme based on appearance
local function scheme_for_appearance(appearance)
    if appearance:find("Dark") then
        return "Gruvbox Material (Gogh)"
    else
        return "rose-pine-dawn"
    end
end

wezterm.on('window-config-reloaded', function(window, pane)
    local overrides = window:get_config_overrides() or {}
    local appearance = window:get_appearance()
    local scheme = scheme_for_appearance(appearance)
    if overrides.color_scheme ~= scheme then
        overrides.color_scheme = scheme
        window:set_config_overrides(overrides)
    end
end)

config.font = wezterm.font("MesloLGS NF")
-- font size
config.font_size = 18.0
config.use_fancy_tab_bar = false

config.colors = {
  tab_bar = {
    -- The color of the inactive tab bar edge/divider
    inactive_tab_edge = '#575757',

  },
}

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
  local zoomed = ''
  if tab.active_pane.is_zoomed then
    zoomed = '[Z] '
  end

  local index = ''
  if #tabs > 1 then
    index = string.format('- [%d/%d] ', tab.tab_index + 1, #tabs)
  end

  return zoomed .. index .. tab.active_pane.title
end)

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
function basename(s)
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local pane = tab.active_pane
    local title = basename(pane.foreground_process_name)
      .. ' :'
      .. tab.tab_index + 1
    local color = '#32302f'
    local fgcolor = '#777777'
    if tab.is_active then
      color = '#faf4ed'
      fgcolor = '#32302f'
    end
    return {
      { Background = { Color = color } },
      { Foreground = { Color = fgcolor} },
      { Text = ' ' .. title .. ' ' },
    }
  end
)
config.keys = {
  -- Set ctrl +t to create a new tab
  {key="t", mods="CTRL", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
  -- switch to tab with ctrl + number
  {key="1", mods="CTRL", action=wezterm.action{ActivateTab=0}},
  {key="2", mods="CTRL", action=wezterm.action{ActivateTab=1}},
  {key="3", mods="CTRL", action=wezterm.action{ActivateTab=2}},
  {key="4", mods="CTRL", action=wezterm.action{ActivateTab=3}},
  {key="5", mods="CTRL", action=wezterm.action{ActivateTab=4}},
  {key="6", mods="CTRL", action=wezterm.action{ActivateTab=5}},
  {key="7", mods="CTRL", action=wezterm.action{ActivateTab=6}},
  {key="8", mods="CTRL", action=wezterm.action{ActivateTab=7}},
  {key="9", mods="CTRL", action=wezterm.action{ActivateTab=8}},
  -- also use alt + number
  {key="1", mods="ALT", action=wezterm.action{ActivateTab=0}},
  {key="2", mods="ALT", action=wezterm.action{ActivateTab=1}},
  {key="3", mods="ALT", action=wezterm.action{ActivateTab=2}},
  {key="4", mods="ALT", action=wezterm.action{ActivateTab=3}},
  {key="5", mods="ALT", action=wezterm.action{ActivateTab=4}},
  {key="6", mods="ALT", action=wezterm.action{ActivateTab=5}},
  {key="7", mods="ALT", action=wezterm.action{ActivateTab=6}},
  {key="8", mods="ALT", action=wezterm.action{ActivateTab=7}},
  {key="9", mods="ALT", action=wezterm.action{ActivateTab=8}},

}

-- and finally, return the configuration to wezterm
return config

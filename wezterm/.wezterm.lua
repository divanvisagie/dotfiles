-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- Dynamically get the home directory
local home = os.getenv("HOME")
package.path = package.path .. ';' .. home .. '/.dotfiles/wezterm/theme/?.lua' -- Add path to imports
local light_theme = require 'rosepinedawn'
local dark_theme = require 'gruvboxdark'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Set no window buttons
config.use_fancy_tab_bar = true

-- Only show bar if there is more than one tab
config.hide_tab_bar_if_only_one_tab = true
--
-- Don't pad the window
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.bold_brightens_ansi_colors = false

-- Set font rules to disable bolding and italics
config.font_rules = {
  {
    -- Matcher
    italic = true, 
    -- Setter
    -- We show regular here, not italic
    font = wezterm.font("MesloLGS NF", {weight="Regular"}),
  },
  {
    -- Matcher
    intensity = "Bold",
    -- Setter
    -- We show regular here, not bold
    font = wezterm.font("MesloLGS NF", {weight="Regular"}),
  },
}

-- Function to choose a color scheme based on appearance
local function scheme_for_appearance(appearance)
    if appearance:find("Dark") then
        return "Gruvbox Material (Gogh)"
    else
        return "rose-pine-dawn"
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

config.font = wezterm.font("MesloLGS NF")
if wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
    config.font_size = 17.0
    config.window_decorations = "NONE"
else
    config.font_size = 20.0
    config.window_decorations = "RESIZE"
end

wezterm.on('window-config-reloaded', function(window, pane)
    local overrides = window:get_config_overrides() or {}
    local appearance = window:get_appearance()
    local scheme = scheme_for_appearance(appearance)
    local override_theme = get_theme(appearance)

        overrides.color_scheme = scheme
        overrides.colors = override_theme
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

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local pane = tab.active_pane
    -- local title = tab.tab_index.. ': ' .. tab.active_pane.title
    local title = tab_title(tab)

    local color = '#32302f'
    local fgcolor = '#777777'

    if tab.is_active then
      -- We detect dark mode by detecting the theme
      if config.color_scheme == 'rose-pine-dawn' then
        color = '#faf4ed'
        fgcolor = '#32302f'
      else
        color = '#282828'
        fgcolor = '#928374'
      end
    end

    return {
      { Background = { Color = color } },
      { Foreground = { Color = fgcolor} },
      { Text = ' ' .. tab.tab_index+1 .. ' │ ' .. title .. ' │'},
    }
  end
)

-- Set the key bind to move right one split as alt+ctrl+l
config.keys = {
  {key="l", mods="CTRL|ALT", action=wezterm.action{ActivatePaneDirection="Right"}},
  {key="h", mods="CTRL|ALT", action=wezterm.action{ActivatePaneDirection="Left"}},
  {key="j", mods="CTRL|ALT", action=wezterm.action{ActivatePaneDirection="Down"}},
  {key="k", mods="CTRL|ALT", action=wezterm.action{ActivatePaneDirection="Up"}},
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

-- We have to return the config
return config

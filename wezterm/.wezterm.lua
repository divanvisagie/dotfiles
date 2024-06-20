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

-- We have to return the config
return config

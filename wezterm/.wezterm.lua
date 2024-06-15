-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Set no window buttons
config.use_fancy_tab_bar = false


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

if wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
    config.font = wezterm.font("MesloLGS NF")
    config.font_size = 17.0
    config.window_decorations = "NONE"
else
    config.font = wezterm.font("MesloLGS NF")
    config.font_size = 20.0
    config.window_decorations = "RESIZE"
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


config.colors = {
  tab_bar = {
    -- The color of the inactive tab bar edge/divider
    inactive_tab_edge = '#575757',
  },
}

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
      -- We detect dark mode by detecting the theme
      if config.color_scheme == 'rose-pine-dawn' then
        color = '#faf4ed'
        fgcolor = '#32302f'
      else
        color = '#282828'
        fgcolor = '#928374'
      end
    end

    -- Get the name of the folder we are in
    local dir_name = ''
    if pane then
      -- Pane to string
      local pane_str = tostring(pane)
      print(pane_str)
    end

    return {
      { Background = { Color = color } },
      { Foreground = { Color = fgcolor} },
      { Text = ' ' .. title .. ' ' .. dir_name },
    }
  end
)

-- key bindings
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

-- We have to return the config
return config

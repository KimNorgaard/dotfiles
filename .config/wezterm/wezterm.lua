local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.switch_to_last_active_tab_when_closing_tab = true
config.tab_max_width = 32

config.font = wezterm.font({ family = "GoMono Nerd Font Mono", weight = "Regular" })
-- config.font = wezterm.font({ family = "MesloLGS Nerd Font", weight = "Regular" })
config.font_size = 16.0

config.window_decorations = "RESIZE"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.initial_cols = 120
config.initial_rows = 50

config.scrollback_lines = 5000

config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.7,
}
config.pane_focus_follows_mouse = true

config.unix_domains = {
  {
    name = "unix",
  },
}
-- config.default_gui_startup_args = { "connect", "unix" }
-- config.default_domain = "unix"

config.audible_bell = "Disabled"

config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = { CubicBezier = { 0.0, 0.0, 1.0, 1.0 } }
config.cursor_blink_ease_out = { CubicBezier = { 0.0, 0.0, 1.0, 1.0 } }

config.color_scheme = "amber"
config.color_schemes = {
  ["amber"] = {
    background = "#000000",
    foreground = "#ffa028",
    cursor_bg = "#ffa028",
    cursor_border = "#ffa028",
    cursor_fg = "#000000",
    selection_bg = "#ffa028",
    selection_fg = "#000000",

    ansi = { "#000000", "#FF3428", "#f6fe11", "#c2a86c", "#7a4f17", "#7a4f17", "#ffa028", "#ffa028" },
    brights = { "#666666", "#feba11", "#777777", "#feba11", "#feba11", "#feba11", "#ffa028", "#ffa028" },
  },
  ["Muh Theme"] = {
    foreground = "#eceef0",
    background = "#282522",
    cursor_bg = "#b69d43",
    cursor_fg = "#e8e8e8",
    cursor_border = "#52ad70",
    selection_fg = "#eceef0",
    selection_bg = "#657c89",
    scrollbar_thumb = "#222222",
    split = "#444444",
    ansi = { "#596c77", "#eb5f59", "#8eedb3", "#f8d85e", "#68c1f9", "#eb5181", "#8ff8db", "#fefefe" },
    brights = { "#b2bcc3", "#ef9084", "#c5f4cd", "#fae58d", "#94d5fa", "#ee86aa", "#bafaeb", "#fefefe" },
    compose_cursor = "orange",

    copy_mode_active_highlight_bg = { Color = "#000000" },
    copy_mode_active_highlight_fg = { AnsiColor = "Black" },
    copy_mode_inactive_highlight_bg = { Color = "#52ad70" },
    copy_mode_inactive_highlight_fg = { AnsiColor = "White" },

    quick_select_label_bg = { Color = "peru" },
    quick_select_label_fg = { Color = "#ffffff" },
    quick_select_match_bg = { AnsiColor = "Navy" },
    quick_select_match_fg = { Color = "#ffffff" },
  },
}

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
  { key = "a", mods = "LEADER|CTRL",  action = act.SendKey({ mods = "CTRL", key = "a" }) },
  { key = "[", mods = "LEADER",       action = act.ActivateCopyMode },
  { key = "z", mods = "LEADER",       action = act.TogglePaneZoomState },
  { key = "c", mods = "LEADER",       action = act.SpawnTab("CurrentPaneDomain") },
  { key = "n", mods = "LEADER",       action = act.ActivateTabRelative(1) },
  { key = "p", mods = "LEADER",       action = act.ActivateTabRelative(-1) },
  { key = "w", mods = "LEADER",       action = act.ShowTabNavigator },
  { key = "1", mods = "LEADER",       action = act.ActivateTab(0) },
  { key = "2", mods = "LEADER",       action = act.ActivateTab(1) },
  { key = "3", mods = "LEADER",       action = act.ActivateTab(2) },
  { key = "4", mods = "LEADER",       action = act.ActivateTab(3) },
  { key = "5", mods = "LEADER",       action = act.ActivateTab(4) },
  { key = "6", mods = "LEADER",       action = act.ActivateTab(5) },
  { key = "7", mods = "LEADER",       action = act.ActivateTab(6) },
  { key = "8", mods = "LEADER",       action = act.ActivateTab(7) },
  { key = "9", mods = "LEADER",       action = act.ActivateTab(8) },
  { key = "X", mods = "LEADER|SHIFT", action = act.CloseCurrentTab({ confirm = true }) },
  { key = "h", mods = "LEADER",       action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER",       action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER",       action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER",       action = act.ActivatePaneDirection("Right") },
  { key = "H", mods = "LEADER",       action = act.AdjustPaneSize({ "Left", 5 }) },
  { key = "J", mods = "LEADER",       action = act.AdjustPaneSize({ "Down", 5 }) },
  { key = "K", mods = "LEADER",       action = act.AdjustPaneSize({ "Up", 5 }) },
  { key = "L", mods = "LEADER",       action = act.AdjustPaneSize({ "Right", 5 }) },
  {
    key = "r",
    mods = "LEADER",
    action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
  },
  { key = "a", mods = "LEADER", action = act.AttachDomain("unix") },
  { key = "d", mods = "LEADER", action = act.DetachDomain({ DomainName = "unix" }) },
  { key = "s", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "WORKSPACES" }) },
  {
    key = "|",
    mods = "LEADER|SHIFT",
    action = act.SplitPane({ direction = "Right", size = { Percent = 50 } }),
  },
  { key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "-",  mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
}

config.key_tables = {
  resize_pane = {
    { key = "h",      action = act.AdjustPaneSize({ "Left", 1 }) },
    { key = "l",      action = act.AdjustPaneSize({ "Right", 1 }) },
    { key = "k",      action = act.AdjustPaneSize({ "Up", 1 }) },
    { key = "j",      action = act.AdjustPaneSize({ "Down", 1 }) },

    { key = "Escape", action = "PopKeyTable" },
  },
}

config.front_end = "WebGpu"

wezterm.on("update-status", function(window, pane)
  window:set_right_status(wezterm.format({
    { Text = " " .. pane:get_domain_name() },
  }))
end)

return config

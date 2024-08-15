local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.audible_bell = "Disabled"

-- config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.switch_to_last_active_tab_when_closing_tab = true
config.tab_max_width = 32

config.hyperlink_rules = wezterm.default_hyperlink_rules()

config.window_decorations = "RESIZE"

config.font = wezterm.font({ family = "GoMono Nerd Font Mono", weight = "Regular" })
config.font_size = 16.0
-- config.bold_brightens_ansi_colors = true

config.initial_cols = 120
config.initial_rows = 50

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

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
  { key = "[", mods = "LEADER",       action = wezterm.action.ActivateCopyMode },
  { key = "z", mods = "LEADER",       action = wezterm.action.TogglePaneZoomState },
  { key = "c", mods = "LEADER",       action = wezterm.action.SpawnTab("CurrentPaneDomain") },
  { key = "n", mods = "LEADER",       action = wezterm.action.ActivateTabRelative(1) },
  { key = "p", mods = "LEADER",       action = wezterm.action.ActivateTabRelative(-1) },
  { key = "w", mods = "LEADER",       action = wezterm.action.ShowTabNavigator },
  { key = "1", mods = "LEADER",       action = wezterm.action.ActivateTab(0) },
  { key = "2", mods = "LEADER",       action = wezterm.action.ActivateTab(1) },
  { key = "3", mods = "LEADER",       action = wezterm.action.ActivateTab(2) },
  { key = "4", mods = "LEADER",       action = wezterm.action.ActivateTab(3) },
  { key = "5", mods = "LEADER",       action = wezterm.action.ActivateTab(4) },
  { key = "6", mods = "LEADER",       action = wezterm.action.ActivateTab(5) },
  { key = "7", mods = "LEADER",       action = wezterm.action.ActivateTab(6) },
  { key = "8", mods = "LEADER",       action = wezterm.action.ActivateTab(7) },
  { key = "9", mods = "LEADER",       action = wezterm.action.ActivateTab(8) },
  { key = "X", mods = "LEADER|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
  { key = "h", mods = "LEADER",       action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER",       action = wezterm.action.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER",       action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER",       action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "H", mods = "LEADER",       action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
  { key = "J", mods = "LEADER",       action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
  { key = "K", mods = "LEADER",       action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
  { key = "L", mods = "LEADER",       action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
  {
    key = "r",
    mods = "LEADER",
    action = wezterm.action.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
  },
  { key = "a", mods = "LEADER", action = wezterm.action.AttachDomain("unix") },
  { key = "d", mods = "LEADER", action = wezterm.action.DetachDomain({ DomainName = "unix" }) },
  { key = "s", mods = "LEADER", action = wezterm.action.ShowLauncherArgs({ flags = "WORKSPACES" }) },
  {
    key = "|",
    mods = "LEADER|SHIFT",
    action = wezterm.action.SplitPane({ direction = "Right", size = { Percent = 50 } }),
  },
  { key = "\\", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "-",  mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
}

config.key_tables = {
  resize_pane = {
    { key = "h",      action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
    { key = "l",      action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
    { key = "k",      action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
    { key = "j",      action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },

    { key = "Escape", action = "PopKeyTable" },
  },
}

wezterm.on("update-status", function(window, pane)
  window:set_right_status(wezterm.format({
    { Text = " " .. pane:get_domain_name() },
  }))
end)

return config

local wezterm = require("wezterm")

local font = { family = "Input Mono", weight = "Light" }

local function resize_font(window)
    local window_size = window:get_dimensions()
    local overrides = window:get_config_overrides() or {}

    if window_size.dpi < 100 then
        overrides.font_size = 13
    else
        overrides.font_size = 14
    end

    window:set_config_overrides(overrides)
end

wezterm.on("window-resized", resize_font)
wezterm.on("window-config-reloaded", resize_font)

return {
    color_scheme = "rose-pine",
    enable_kitty_keyboard = false,
    font = wezterm.font(font),
    font_size = 14,
    native_macos_fullscreen_mode = true,
    send_composed_key_when_left_alt_is_pressed = false,
    send_composed_key_when_right_alt_is_pressed = true,
    show_new_tab_button_in_tab_bar = false,
    tab_bar_at_bottom = true,
    use_fancy_tab_bar = false,
    window_decorations = "RESIZE",

    colors = {
        selection_bg = "#403d52",
        tab_bar = {
            background = "#21202e",
            inactive_tab = { bg_color = "#1f1d2e", fg_color = "#908caa" },
            active_tab = { bg_color = "#26233a", fg_color = "#e0def4" },
        },
    },

    keys = {
        { mods = "CMD", key = "d", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
        { mods = "CMD|SHIFT", key = "d", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
        { mods = "CMD", key = "[", action = wezterm.action.ActivatePaneDirection("Prev") },
        { mods = "CMD", key = "]", action = wezterm.action.ActivatePaneDirection("Next") },
        { mods = "CMD|ALT", key = "UpArrow", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
        { mods = "CMD|ALT", key = "DownArrow", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
        { mods = "CMD|ALT", key = "LeftArrow", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
        { mods = "CMD|ALT", key = "RightArrow", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
        {
            mods = "CMD|OPT",
            key = "v",
            action = wezterm.action_callback(function(_, pane)
                local f = assert(io.popen("pbpaste", "r"))
                local raw_text = assert(f:read("*a"))
                f:close()
                local text = wezterm.shell_quote_arg(raw_text)
                pane:paste(text)
            end),
        },
        { mods = "ALT", key = "Enter", action = wezterm.action.DisableDefaultAssignment },
    },
}

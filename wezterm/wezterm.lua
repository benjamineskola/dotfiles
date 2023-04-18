local wezterm = require("wezterm")

local font = { family = "Input Mono", weight = "Light", harfbuzz_features = { "zero" } }

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
    color_scheme = "Monokai Pro (Gogh)",
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
        ansi = { "#363537", "#ff6188", "#a9dc76", "#fc9867", "#ab9df2", "#ff6188", "#78dce8", "#fdf9f3" },
        background = "#2d2a2e",
        brights = { "#908e8f", "#ff6188", "#a9dc76", "#ffd866", "#ab9df2", "#ff6188", "#78dce8", "#fdf9f3" },
        cursor_bg = "#5b595c",
        tab_bar = {
            background = "#363537",
            inactive_tab = { bg_color = "#363537", fg_color = "#fdf9f3" },
            active_tab = { bg_color = "#2d2a2e", fg_color = "#fdf9f3" },
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

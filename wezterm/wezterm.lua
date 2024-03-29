local wezterm = require("wezterm")

local font = { family = "JetBrains Mono", weight = "Light" }

return {
    color_scheme = "Catppuccin Mocha",
    enable_kitty_keyboard = false,
    font = wezterm.font(font),
    font_size = 13,
    harfbuzz_features = { "calt=0", "dlig=0" }, -- differs by font, could also be clig or liga
    native_macos_fullscreen_mode = true,
    send_composed_key_when_left_alt_is_pressed = false,
    send_composed_key_when_right_alt_is_pressed = true,
    show_new_tab_button_in_tab_bar = false,
    tab_bar_at_bottom = true,
    use_fancy_tab_bar = false,
    window_decorations = "RESIZE",

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

local wezterm = require("wezterm")

return {
    color_scheme = "tokyonight",
    font = wezterm.font({ family = "Fira Code", weight = "Light", harfbuzz_features = { "zero" } }),
    font_size = 14,
    native_macos_fullscreen_mode = true,
    send_composed_key_when_left_alt_is_pressed = false,
    send_composed_key_when_right_alt_is_pressed = true,
    show_new_tab_button_in_tab_bar = false,
    tab_bar_at_bottom = true,
    use_fancy_tab_bar = false,
    window_decorations = "RESIZE",
}

local wezterm = require("wezterm")

local font = { family = "Fira Code", weight = "Light", harfbuzz_features = { "zero" } }

local function set_colour_scheme(window)
    local overrides = window:get_config_overrides() or {}
    local dark_mode = os.execute([[defaults read -globalDomain AppleInterfaceStyle]])

    if dark_mode then
        overrides.color_scheme = "tokyonight"
        local light_font = font
        light_font.weight = "Light"
        overrides.font = wezterm.font(light_font)
    else
        overrides.font = wezterm.font(font)
        overrides.color_scheme = "tokyonight-day"
    end

    window:set_config_overrides(overrides)
end

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

wezterm.on("window-focus-changed", set_colour_scheme)
wezterm.on("window-config-reloaded", set_colour_scheme)

return {
    color_scheme = "tokyonight",
    font = wezterm.font(font),
    font_size = 14,
    native_macos_fullscreen_mode = true,
    send_composed_key_when_left_alt_is_pressed = false,
    send_composed_key_when_right_alt_is_pressed = true,
    show_new_tab_button_in_tab_bar = false,
    tab_bar_at_bottom = true,
    use_fancy_tab_bar = false,
    window_decorations = "RESIZE",
}

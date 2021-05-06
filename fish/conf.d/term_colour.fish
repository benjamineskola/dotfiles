function is_darkmode
    set dark_mode (osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode.get()")
    test "$dark_mode" = true
    return $status
end

function was_darkmode
    if test "$ARGS" = -f || ! test -e ~/Library/Caches/darkmode.txt
        if is_darkmode
            return 1
        else
            return 0
        end
    end
    set dark_mode (cut -d ' ' -f 2 ~/Library/Caches/darkmode.txt)
    test "$dark_mode" = true
    return $status
end

function iterm_theme
    osascript -l JavaScript -e "
    windows = Application('iTerm').windows()
    for (w in windows)
    {
        tabs = windows[w].tabs()
        for (t in tabs) {
            sessions = tabs[t].sessions()
            for (s in sessions) {
                sessions[s].colorPreset = '$1'
            }
        }
    }" >/dev/null 2>&1
end

function term_colour --on-event fish_prompt
    if is_darkmode && ! was_darkmode
        if test "$TERM_PROGRAM" = iTerm.app
            iterm_theme gruvbox-dark
        else
            # assume alacritty
            sed -i '' '/colors:/s/light/dark/g' ~/.config/alacritty/alacritty.yml
            sed -i '' '/style:/s/Light/Thin/g' ~/.config/alacritty/alacritty.yml
        end
        sed -i '' s/gruvbox-light/gruvbox-dark/g ~/.config/git/config ~/.config/bat/config

        echo (date +%s) true >~/Library/Caches/darkmode.txt
    else if was_darkmode && ! is_darkmode
        if test "$TERM_PROGRAM" = iTerm.app
            iterm_theme gruvbox-light
        else
            # assume alacritty
            sed -i '' '/colors:/s/dark/light/g' ~/.config/alacritty/alacritty.yml
            sed -i '' '/style:/s/Thin/Light/g' ~/.config/alacritty/alacritty.yml
        end
        sed -i '' s/gruvbox-dark/gruvbox-light/g ~/.config/git/config ~/.config/bat/config

        echo (date +%s) false >~/Library/Caches/darkmode.txt
    end
end
term_colour

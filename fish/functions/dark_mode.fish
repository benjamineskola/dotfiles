function dark_mode
    set dark_mode (osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode.get()")
    if test $dark_mode = true
        return 0
    else
        return 1
    end
end

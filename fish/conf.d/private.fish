for file in $XDG_CONFIG_HOME/private/fish/*.fish
    builtin source $file 2>/dev/null
end

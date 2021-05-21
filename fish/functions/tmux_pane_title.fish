function tmux_pane_title
    printf '\033]2;%s\033\\' "$argv"
end

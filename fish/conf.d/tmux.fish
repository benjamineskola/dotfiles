function set_tmux_name --on-event fish_prompt
    tmux rename-window (prompt_pwd)
end

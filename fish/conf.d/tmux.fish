function set_tmux_dir_name --on-event fish_prompt
    tmux rename-window (prompt_pwd)
end
function set_tmux_command_name --on-event fish_preexec
    tmux rename-window (string sub -l 20 $argv)
end

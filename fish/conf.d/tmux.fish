if test -n "$TMUX"
    set -x TMUX_WINDOW (tmux display-message -p '#{window_id}')
    function tmux_pane_rename_cmd -e fish_preexec
        if string match -vq 'cd*' $argv
            and string match -vq 'z *' $argv
            and test 'z' != $argv
            tmux rename-window -t $TMUX_WINDOW (string replace -r ' .*$' '' $argv):\ (basename (string replace "$HOME" '~' $PWD))
        end
    end

    function tmux_pane_rename_pwd -e fish_prompt
        tmux rename-window -t $TMUX_WINDOW (basename (string replace "$HOME" '~' $PWD))
        tmux refresh-client -S
    end

    tmux_pane_rename_pwd
end

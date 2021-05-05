function __fzf_cd --description 'Search the home directory using fzf and fd. Change to the selected directory'
    # Make sure that fzf uses fish to execute __fzf_preview_file.
    # See similar comment in __fzf_search_shell_variables.fish.
    set --local --export SHELL (command --search fish)

    set open_status 0

    set dir (fd --hidden --follow --color=always --exclude "{.git,.Trash,Library,Movies,Music,Pictures}" --type directory . $HOME 2>/dev/null | fzf --ansi --preview='__fzf_preview_file {}')

    if test $status -eq 0
        commandline -r "cd "
        commandline -a (string escape "$dir")

        commandline -f execute
        set open_status $status
    end

    commandline -f repaint

    return $open_status
end

function __fzf_insert_file --description 'Search the current directory using fzf and fd. Insert the filename in the current commandline at the cursor position.'
    # Make sure that fzf uses fish to execute __fzf_preview_file.
    # See similar comment in __fzf_search_shell_variables.fish.
    set --local --export SHELL (command --search fish)

    set open_status 0

    set file_paths_selected (fd --hidden --follow --color=always --exclude "{.git,.Trash,Library,Movies,Music,Pictures}" --type file 2>/dev/null | fzf --multi --ansi --preview='__fzf_preview_file {}')

    if test $status -eq 0
        for path in $file_paths_selected
            set escaped_path (string escape "$path")
            if ! string match "* " (commandline -c)
                commandline -i " "
            end
            commandline -i "$escaped_path"
        end
    end
    commandline -f repaint
end

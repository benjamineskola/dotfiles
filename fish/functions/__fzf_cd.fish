function __fzf_cd --description 'Search the current directory using fzf and fd. Open the file with the default editor.'
    # Make sure that fzf uses fish to execute __fzf_preview_file.
    # See similar comment in __fzf_search_shell_variables.fish.
    set --local --export SHELL (command --search fish)
    cd (fd --hidden --follow --color=always --exclude "{.git,.Trash,Library,Movies,Music,Pictures}" --type directory . $HOME 2>/dev/null |
    fzf --ansi --preview='__fzf_preview_file {}')
    commandline --function repaint
end

function __fzf_open_file --description 'Search the current directory using fzf and fd. Open the file with the default editor.'
    # Make sure that fzf uses fish to execute __fzf_preview_file.
    # See similar comment in __fzf_search_shell_variables.fish.
    set --local --export SHELL (command --search fish)
    fd --hidden --follow --color=always --exclude=.git --type file 2>/dev/null |
    fzf --multi --ansi --preview='__fzf_preview_file {}' | xargs $EDITOR
end

function __fzf_cd --description 'Search the home directory using fzf and z. Change to the selected directory'
    set dir (z -l | awk '{print $2}' | fzf --preview 'exa -G {}' --cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*")

    if [ $status -eq 0 ]
        commandline -r "z "
        commandline -a (string escape "$dir")
        commandline -f execute
    end

    commandline -f repaint
end

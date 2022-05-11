function __fzf_cd --description 'Search the home directory using fzf and z. Change to the selected directory'
    set dir (z -l | cut -w -f 2 | fzf --preview 'exa -G {}')
    if [ $status -eq 0 ]
        z "$dir"
    end
    commandline -f repaint
end

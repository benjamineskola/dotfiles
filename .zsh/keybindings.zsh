bindkey -e

function insert-last-line { zle set-mark-command; LBUFFER+="$(fc -ln -1)"; }
zle -N insert-last-line
bindkey '\e,' insert-last-line

setopt nonomatch


fpath=($fpath ~/.zsh/$OS/functions.zwc ~/.zsh/functions.zwc)
autoload -U ${^fpath%.zwc}/*(.N:t)
zrecompile -p ~/.zsh/functions.zwc ~/.zsh/functions/*

path=(~/bin /usr/local/bin /usr/local/sbin /usr/local/games /usr/bin /usr/sbin /usr/games /bin /sbin)

export LESS="-ImRswFX"
export LESSHISTFILE="$XDG_CACHE_HOME/less_history"
export MANPAGER="less +Gg"

export TZ=Europe/London

export LSCOLORS=exfxcxdxbxegedabagacad

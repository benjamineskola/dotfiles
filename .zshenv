setopt nonomatch

FQDN=$(hostname -f || hostname)
HOSTNAME=${FQDN%%.*}
DOMAIN=${FQDN#*.}
export HOSTNAME DOMAIN FQDN

export OS=${OSTYPE%%[0-9.]*}

fpath=($fpath ~/.zsh/$OS/functions.zwc ~/.zsh/functions.zwc)
autoload -U ${^fpath%.zwc}/*(.N:t)
zrecompile -p ~/.zsh/functions.zwc ~/.zsh/functions/*

path=(~/bin /usr/local/bin /usr/local/sbin /usr/local/games /usr/bin /usr/sbin /usr/games /bin /sbin)

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/Library
export XDG_CACHE_HOME=$HOME/Library/Caches

export LESS="-ImRswFX"
export LESSHISTFILE="$XDG_CACHE_HOME/less_history"
export MANPAGER="less +Gg"

export TZ=Europe/London

export LSCOLORS=exfxcxdxbxegedabagacad

if [ -f ~/.zshenv.$HOSTNAME.zsh ]; then
	source ~/.zshenv.$HOSTNAME.zsh
fi

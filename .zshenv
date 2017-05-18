# -*- zsh -*-

setopt nonomatch

FQDN=$(hostname -f || hostname)
HOSTNAME=${FQDN%%.*}
DOMAIN=${FQDN#*.}
export HOSTNAME DOMAIN FQDN

export OS=${OSTYPE%%[0-9.]*}

fpath=($fpath ~/.zsh/$OS/functions.zwc ~/.zsh/functions.zwc)
autoload -U ${^fpath%.zwc}/*(.N:t)

path=(~/bin /usr/local/bin /usr/local/sbin /usr/local/games /usr/bin /usr/sbin /usr/games /bin /sbin)

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/Library
export XDG_CACHE_HOME=$HOME/Library/Caches

export AWS_PROFILE=home

export EDITOR=vi
export VISUAL=$EDITOR

export LESS="-ImRswFX"
export LESSHISTFILE="$XDG_CACHE_HOME/less_history"
export MANPAGER="less +Gg"


export TZ=Europe/London

path=(/usr/local/MacGPG2/bin /usr/local/texlive/*/bin/* $path)

export PYTHONPATH=$HOME/Library/Python/2.7
path=($path $PYTHONPATH/bin)

export LSCOLORS=exfxcxdxbxegedabagacad

if [[ $HOSTNAME = ELSLABM-155889 ]]; then
  export AWS_PROFILE=work

  export GIT_AUTHOR_EMAIL=bma@elsevier.com
  export GIT_COMMITTER_EMAIL=bma@elsevier.com
fi

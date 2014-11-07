# -*- sh -*-

OS=${OSTYPE%%[0-9.]*}

FQDN=$(hostname -f || hostname) # on solaris, hostname -f won't work
HOSTNAME=${FQDN%%.*}
DOMAIN=${FQDN#*.}
export HOSTNAME DOMAIN FQDN

export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.data

PATH=~/bin:/usr/local/bin:/usr/local/sbin:/usr/local/games:/usr/bin:/usr/sbin:/usr/games:/bin:/sbin
export PATH

EDITOR=vi
if [[ -x "$(which vim)" ]]; then
	EDITOR=vim
fi
VISUAL=$EDITOR
export EDITOR VISUAL

export LESS="-ImRswFX"
if [[ -x "$(which lesspipe.sh)" ]]; then
	export LESSOPEN="|lesspipe.sh %s"
elif [[ -x "$(which lesspipe)" ]]; then
	export LESSOPEN="|lesspipe %s"
fi

export TZ=Europe/London

test -e ~/.zsh/$OS/environment && . ~/.zsh/$OS/environment
test -e ~/.zsh/environment.after && . ~/.zsh/environment.after

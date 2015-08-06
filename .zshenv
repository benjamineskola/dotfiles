setopt nonomatch

OS=${OSTYPE%%[0-9.]*}

FQDN=$(hostname -f || hostname) # on solaris, hostname -f won't work
HOSTNAME=${FQDN%%.*}
DOMAIN=${FQDN#*.}
export HOSTNAME DOMAIN FQDN

export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.data

path=(~/bin /usr/local/bin /usr/local/sbin /usr/local/games /usr/bin /usr/sbin /usr/games /bin /sbin)

for fdir in ~/.zsh/$OS/functions ~/.zsh/functions; do
	test -d "$fdir" && fpath+="$fdir" && autoload -U "$fdir"/*(:t)
done

export EDITOR=vi
export VISUAL=$EDITOR

export LESS="-ImRswFX"
export LESSHISTFILE="$XDG_CACHE_HOME/less_history"
export MANPAGER="less +Gg"

export TZ=Europe/London

load_aws_config home

test -e ~/.zsh/"$OS"/environment && . ~/.zsh/"$OS"/environment
test -e ~/.zsh/"$HOSTNAME"/environment && . ~/.zsh/"$HOSTNAME"/environment

. /usr/local/share/chruby/chruby.sh
. /usr/local/share/chruby/auto.sh
chruby 2

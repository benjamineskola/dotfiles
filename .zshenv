# -*- sh -*-

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
	test -d $fdir && fpath+=$fdir && autoload -U $fdir/*(:t)
done

EDITOR=vi
if [[ -x "$(which vim)" ]]; then
	EDITOR=vim
fi
VISUAL=$EDITOR
export EDITOR VISUAL

export LESS="-ImRswFX"
export TZ=Europe/London

if [[ $HOSTNAME = mbuni ]]; then
	export GIT_AUTHOR_EMAIL=bma@mendeley.com
	export GIT_COMMITTER_EMAIL=bma@mendeley.com

	load_aws_config work
else
	load_aws_config home
fi

test -e ~/.zsh/$OS/environment && . ~/.zsh/$OS/environment
test -e ~/.zsh/environment.after && . ~/.zsh/environment.after

. /usr/local/share/chruby/chruby.sh
. /usr/local/share/chruby/auto.sh
chruby 2

# vim:ft=sh

FQDN=$(hostname -f || hostname) # on solaris, hostname -f won't work
HOSTNAME=${FQDN%%.*}
DOMAIN=${FQDN#*.}
export HOSTNAME DOMAIN FQDN

# store the name of the operating system and architecture.
OSTYPE=$(uname -s)
MACHTYPE=$(uname -m)
export OSTYPE MACHTYPE

export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.data

if [ $OSTYPE = Darwin ]; then
	export XDG_DATA_HOME=$HOME/Library
	export XDG_CACHE_HOME=$HOME/Library/Caches
fi

PATH=/bin:/sbin
PATH=/usr/bin:/usr/sbin:/usr/games:$PATH
PATH=/usr/local/bin:/usr/local/sbin:/usr/local/games:$PATH
if [ -d /usr/lib/hadoop ]; then PATH=$PATH:/usr/lib/hadoop/bin; fi
if [ -d /usr/lib/hbase ]; then PATH=$PATH:/usr/lib/hbase/bin; fi
PATH=~/bin/$OSTYPE/$MACHTYPE:~/bin/$OSTYPE:~/bin:$PATH
export PATH

EDITOR=vi
if [ -x "$(which vim)" ]; then
	EDITOR=vim
	alias vi=vim
fi
VISUAL=$EDITOR
export EDITOR VISUAL

LESS="-ImRswFX"
LESSHISTFILE="-"
export LESS LESSHISTFILE

export LS_COLORS="no=00:fi=00:di=01;34:ln=35:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=31" # gnu
export LSCOLORS=Exfxcxdxbxegedabagacad # bsd
export LEDGER_FILE="${XDG_DATA_HOME}/ledger/accounts"
export PACKAGESITE=ftp://ftp.freebsd.org/pub/FreeBSD/ports/amd64/packages-9-stable/Latest/

LANG=en_GB.UTF-8
LC_COLLATE=C
export LANG LC_COLLATE

case $DOMAIN in
	*mendeley.*|*.chonp.net)
		GIT_AUTHOR_EMAIL=bma@mendeley.com
		;;
	*)
		GIT_AUTHOR_EMAIL=bma@bma.li
		;;
esac
GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL
export GIT_AUTHOR_EMAIL GIT_COMMITTER_EMAIL

export TZ=Europe/London

if [ -x /usr/local/bin/virtualenvwrapper.sh ]; then
	export WORKON_HOME=$HOME/Code/virtualenvs
	export PROJECT_HOME=$HOME/Code
	. /usr/local/bin/virtualenvwrapper.sh
	if [[ -n "$VIRTUAL_ENV" ]]; then
		export PATH=$VIRTUAL_ENV/bin:$PATH
	fi
fi

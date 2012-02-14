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

PATH=/bin:/sbin
PATH=/usr/bin:/usr/sbin:/usr/games:$PATH
PATH=/usr/local/bin:/usr/local/sbin:/usr/local/games:$PATH
PATH=/usr/pkg/bin:/usr/pkg/sbin:/usr/pkg/games:$PATH
if [ -d /var/lib/gems ]; then for i in /var/lib/gems/*; do if [ -d $i/bin ]; then PATH=$i/bin:$PATH; fi; done; fi
for i in site vendor core; do if [ -d /usr/lib/perl5/${i}_perl/bin ]; then PATH=/usr/lib/perl5/${i}_perl/bin:$PATH; fi; done
if [ -d /usr/lib/hadoop ]; then PATH=$PATH:/usr/lib/hadoop/bin; fi
if [ -d /usr/lib/hbase ]; then PATH=$PATH:/usr/lib/hbase/bin; fi
PATH=~/bin/$OSTYPE/$MACHTYPE:~/bin/$OSTYPE:~/bin:$PATH
export PATH

test -x ~/.data/lib && LD_LIBRARY_PATH=~/.data/lib:$LD_LIBRARY_PATH
test -x ~/.data/lib/perl5/site_perl/ && PERLLIB=$(echo ~/.data/lib/perl5/site_perl/*|sed 's/ /:/g')
test -x ~/.data/share/man && MANPATH=~/.data/share/man:$(manpath)
test -x ~/.data/lib/python && PYTHONPATH=~/.data/lib/python:$PYTHONPATH

EDITOR=vi
if [ -x "$(which vim)" ]; then
	EDITOR=vim
	alias vi=vim
fi
VISUAL=$EDITOR
export EDITOR VISUAL

RXVT_SOCKET="${XDG_CACHE_HOME}/urxvt-socket-${FQDN}"
export RXVT_SOCKET

LESS="-ImRswFX"
LESSHISTFILE="-"
export LESS LESSHISTFILE

export LS_COLORS="no=00:fi=00:di=01;34:ln=35:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=31" # gnu
export LSCOLORS=Exfxcxdxbxegedabagacad # bsd

export LEDGER_FILE="${XDG_DATA_HOME}/ledger/accounts"

export PAPERSIZE=a4

PACKAGESITE=ftp://ftp.freebsd.org/pub/FreeBSD/ports/amd64/packages-8-stable/Latest/

LANG=en_GB.UTF-8
LC_COLLATE=C
export LANG LC_COLLATE

case $DOMAIN in
	mendeley.com|mendeley.lan|mendeley.internal|chonp.net)
		GIT_AUTHOR_EMAIL=bma@mendeley.com
		;;
	*)
		GIT_AUTHOR_EMAIL=bma@bma.li
		;;
esac
GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL
export GIT_AUTHOR_EMAIL GIT_COMMITTER_EMAIL

export TODOTXT_CFG_FILE=${XDG_DATA_HOME}/todo/config

if [ "$HOSTNAME" = "kropotkin" ]; then
	# work
	LAT=51.5223
	LON=-0.10985
else
	# probably laptop, use home coords.
	LAT=51.54753
	LON=-0.03003
fi
export LAT LON

export TZ=Europe/London

if [ "$OSTYPE" = FreeBSD ]; then
	case $TERM in
		rxvt*)
		export TERM=rxvt;;
	esac
fi

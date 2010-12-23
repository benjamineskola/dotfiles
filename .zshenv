HOSTNAME=`hostname -f | cut -d . -f 1`
DOMAIN=`hostname -f | cut -d . -f 2-`
FQDN=$HOSTNAME.$DOMAIN
export HOSTNAME DOMAIN FQDN

# store the name of the operating system and architecture.
OSTYPE=`uname -s`
MACHTYPE=`uname -m`
export OSTYPE MACHTYPE

PATH=/bin:/sbin
PATH=/usr/bin:/usr/sbin:/usr/games:$PATH
PATH=/usr/local/bin:/usr/local/sbin:/usr/local/games:$PATH
PATH=/usr/pkg/bin:/usr/pkg/sbin:/usr/pkg/games:$PATH
if [ -d /var/lib/gems ]; then for i in /var/lib/gems/*; do if [ -d $i/bin ]; then PATH=$i/bin:$PATH; fi; done; fi
if [ -d /usr/lib/hadoop ]; then PATH=$PATH:/usr/lib/hadoop/bin; fi
if [ -d /usr/lib/hbase ]; then PATH=$PATH:/usr/lib/hbase/bin; fi
PATH=~/bin/$OSTYPE/$MACHTYPE:~/bin/$OSTYPE:~/bin:$PATH
export PATH

test -x ~/.data/lib && LD_LIBRARY_PATH=~/.data/lib:$LD_LIBRARY_PATH
test -x ~/.data/lib/perl5/site_perl/ && PERLLIB=`echo ~/.data/lib/perl5/site_perl/*|sed 's/ /:/g'`
test -x ~/.data/share/man && MANPATH=~/.data/share/man:`manpath`
test -x ~/.data/lib/python && PYTHONPATH=~/.data/lib/python:$PYTHONPATH

EDITOR="$HOME/bin/e"
VISUAL=$EDITOR
export EDITOR VISUAL

RXVT_SOCKET=$HOME/.cache/urxvt-socket-`hostname`
export RXVT_SOCKET

LESS="-ImRswFX"
LESSHISTFILE="-"
export LESS LESSHISTFILE

export LS_COLORS="no=00:fi=00:di=34:ln=35:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=31"

export LEDGER_FILE=$HOME/.data/ledger/accounts

export PAPERSIZE=a4

PACKAGESITE=ftp://ftp.freebsd.org/pub/FreeBSD/ports/amd64/packages-8-stable/Latest/

LANG=en_GB.UTF-8
LC_COLLATE=C
export LANG LC_COLLATE

case $DOMAIN in
	mendeley.com|mendeley.lan|mendeley.internal)
		GIT_AUTHOR_EMAIL=bma@mendeley.com
		;;
	*)
		GIT_AUTHOR_EMAIL=bma@bma.cx
		;;
esac
GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL
export GIT_AUTHOR_EMAIL GIT_COMMITTER_EMAIL

if [ -d $HOME/.config/zshenv.d/ ]; then
	for i in $HOME/.config/zshenv.d/*.zsh; do
		. $i
	done
fi

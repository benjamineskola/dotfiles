setopt allexport

HOSTNAME=`hostname -f | cut -d . -f 1`
DOMAIN=`hostname -f | cut -d . -f 2-`
FQDN=$HOSTNAME.$DOMAIN

# store the name of the operating system and architecture.
OSTYPE=`uname -s`
MACHTYPE=`uname -m`

PATH=/bin:/sbin
PATH=/usr/bin:/usr/sbin:/usr/games:$PATH
PATH=/usr/local/bin:/usr/local/sbin:/usr/local/games:$PATH
PATH=/usr/pkg/bin:/usr/pkg/sbin:/usr/pkg/games:$PATH
if [ -d /var/lib/gems ]; then for i in /var/lib/gems/*; do if [ -d $i/bin]; then PATH=$i:$PATH; fi; done; fi
PATH=~/bin/$OSTYPE/$MACHTYPE:~/bin/$OSTYPE:~/bin:$PATH

test -x ~/.data/lib && LD_LIBRARY_PATH=~/.data/lib:$LD_LIBRARY_PATH
test -x ~/.data/lib/perl5/site_perl/ && PERLLIB=`echo ~/.data/lib/perl5/site_perl/*|sed 's/ /:/g'`
test -x ~/.data/share/man && MANPATH=~/.data/share/man:`manpath`
test -x ~/.data/lib/python && PYTHONPATH=~/.data/lib/python:$PYTHONPATH

EDITOR="$HOME/bin/e"
VISUAL=$EDITOR

RXVT_SOCKET=$TMP/urxvt-socket-`hostname`

LESS="-ImRswFX"
LESSHISTFILE="-"

LS_COLORS="no=00:fi=00:di=34:ln=35:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=31"

XAUTHORITY="$HOME/.cache/Xauthority"

LEDGER_FILE=$HOME/doc/finance/accounts

PAPERSIZE=a4

PACKAGESITE=ftp://ftp.freebsd.org/pub/FreeBSD/ports/amd64/packages-8-stable/Latest/

LANG=en_GB.UTF-8
LC_COLLATE=C

if [[ -d $HOME/.config/zshenv.d/ ]]; then
	for i in $HOME/.config/zshenv.d/*.zsh; do
		. $i
	done
fi

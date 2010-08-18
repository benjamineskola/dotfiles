setopt allexport

HOSTNAME=`hostname -f | cut -d . -f 1`
DOMAIN=`hostname -f | cut -d . -f 2-`
FQDN=$HOSTNAME.$DOMAIN

# store the name of the operating system and architecture.
OSTYPE=`uname -s`
MACHTYPE=`uname -m`

path=(
	`test -x ~/bin && echo ~/bin`
	`test -x ~/bin/$OSTYPE && echo ~/bin/$OSTYPE`
	`test -x ~/bin/$OSTYPE/$MACHTYPE && echo ~/bin/$OSTYPE/$MACHTYPE`

	`test -x /usr/pkg/bin && echo /usr/pkg/bin`
	/usr/local/bin
	`test -x /usr/bin/perlbin && echo /usr/bin/perlbin/*` # archlinux crack
	/usr/bin
	/bin
	`test -x /usr/pkg/sbin && echo /usr/pkg/sbin`
	/usr/local/sbin
	/usr/sbin
	/sbin
	`test -x /usr/pkg/games && echo /usr/pkg/games`
	/usr/local/games
	/usr/games
)

test -x ~/.data/lib && LD_LIBRARY_PATH=~/.data/lib:$LD_LIBRARY_PATH
test -x ~/.data/lib/perl5/site_perl/ && PERLLIB=`echo ~/.data/lib/perl5/site_perl/*|sed 's/ /:/g'`
test -x ~/.data/share/man && MANPATH=~/.data/share/man:`manpath`
test -x ~/.data/lib/python && PYTHONPATH=~/.data/lib/python:$PYTHONPATH

EDITOR="$HOME/bin/e"
VISUAL=$EDITOR

TMP=/tmp/bma
TMPDIR=$TMP
mkdir -p $TMP
ln -sf $TMP ~/.tmp

RXVT_SOCKET=$TMP/urxvt-socket-`hostname`

LESS="-ImRswFX"
LESSHISTFILE="-"

LS_COLORS="no=00:fi=00:di=34:ln=35:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=31"

XAUTHORITY="$XDG_CACHE_HOME/Xauthority"

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

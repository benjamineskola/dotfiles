# vim:ft=sh
# functions and aliases to be shared between (at least) zsh and bash.

# define useful aliases for ls based on which *nix we're on.
case $OSTYPE in
	Linux)
		alias ls='ls --color=auto -Fh' ;;
	FreeBSD|Darwin)
		alias ls='ls -GhTp' ;;
	*)
		alias ls='ls -Fh' ;;
esac

# and some generic ones.
alias ll='ls -l'
alias la='ls -A'
alias lal='ls -lA'
alias lsd='ls -d'

alias apg="apg -a 1 -n 1 -c /dev/urandom"
alias dc="dc -e '2k' -f /dev/stdin"
alias df="df -P"
alias feh="feh -FZ"
alias grep='egrep'
alias pt="pstree -auUlp"
alias tf="tail -F"
alias w3m='w3m -F -v'

alias sudo="sudo "

rem(){ (cd ~; command rem -qg $@); }
alias remcal='rem -cuc -w$COLUMNS'

deadlinks(){ i="$1"; test -n "$i" || i=.; find -L "$i" -type l; }

hdus(){ hadoop fs -dus $@ | sort -rn -k2 | awk '{$2=($2/1024/1024/1024) "G";print $2 "\t" $1}' }

if [ -e "$(which colordiff)" ]; then
	alias diff='colordiff -u'
	alias colordiff='colordiff -u'
else
	alias diff='diff -u'
fi

case $OSTYPE in
	Linux)
		if [[ -e /etc/debian_version ]]; then
			alias ack="ack-grep -a"

			alias acs="apt-cache search"
			alias acsh="apt-cache show"
			alias acsno="apt-cache search -n"
			alias sagi="sudo apt-get install --no-install-recommends"
			alias sagir="sudo apt-get install"
			alias sagr="sudo apt-get purge"
			alias sagu="sudo apt-get update"
			alias sagup="sudo apt-get upgrade"

			eval "$(lesspipe)"
		else
			alias ack="ack -a"
		fi
		if [[ -x "$(which bsdtar)" ]]; then
			alias tar=bsdtar
			alias unzip="tar xf"
		fi
		if [[ -x "$(which service)" ]]; then
			alias service='sudo service'
		else
			alias service='sudo invoke-rc.d'
		fi
		;;
	FreeBSD)
		eval "$(lesspipe.sh)"
		alias unzip="tar xf"
		alias ack="ack -a"

		alias spi="sudo portinstall"
		alias spd="sudo pkg_deinstall"
		sps() { type=$1; shift; cd /usr/ports; for i in $@; do make search ${type}=$i; done | less; }
		alias spsn="sps name"
		alias spsk="sps key"

		alias service='sudo service'
		;;
	Darwin)
		alias ack="ack -a"
		;;
esac

f() {
	find $@ | fgrep -v .git/ | while read f; do
		test -d "$f" && printf "\033[01;34m"
		printf "$f\033[0m\n"
	done
}

bal() { ledger -C -s bal Assets Liabilities -Assets:Loans -Assets:CoinJar -Amazon:GiftCert; }
uncleared() { ledger -U print; }

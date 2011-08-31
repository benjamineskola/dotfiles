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
alias w3m='w3m -F -v'

alias grep='egrep'
alias feh="feh -FZ"

alias df="df -P"
alias tf="tail -F"

alias apg="apg -a 1 -n 1 -c /dev/urandom"
alias pt="pstree -auUlp"

rem(){ (cd ~; $(which rem) -qg $@); }
alias remcal='rem -cuc -w$COLUMNS'

sudo(){ command sudo $SHELL -ic '"$0" "$@"' "$@"; }

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

			eval `lesspipe`
		else
			alias ack="ack -a"
		fi
		if [[ -x `which bsdtar` ]]; then
			alias tar=bsdtar
			alias unzip="tar xf"
		fi
		;;
	FreeBSD)
		eval `lesspipe.sh`
		alias unzip="tar xf"
		;;
esac

# vim:ft=sh

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

alias rem='rem -qg'
alias w3m='w3m -F -v'

alias grep='egrep'
alias feh="feh -FZ"

alias df="df -P"
alias tf="tail -F"

alias apg="apg -a 1 -n 1 -c /dev/urandom"
alias pt="pstree -auUlp"

rem(){(cd ~; $(which rem) $@)}
alias remcal='rem -cuc -w$COLUMNS'

sudo(){command sudo $SHELL -ic '"$0" "$@"' "$@";}

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

BASE_PROMPT="%n@%m:%~"
PROMPT="%B$BASE_PROMPT>%b "
TITLE_PROMPT=$BASE_PROMPT
case $TERM in
	xterm*|rxvt*|screen*)
		precmd() {print -Pn "\e]0;$TITLE_PROMPT\a";}
		preexec() {TITLE_PROMPT="$BASE_PROMPT $1";}
		;;
esac

if [[ `whoami` != root ]]; then
	if [[ -x `which keychain` ]]; then
		eval `keychain --eval -q --dir $XDG_CACHE_HOME/keychain`
		ssh-add -l > /dev/null || ssh-add
	fi
fi

HISTFILE=$XDG_CACHE_HOME/zsh_history
HISTSIZE=819200
SAVEHIST=819200
setopt nohist_beep hist_ignore_all_dups share_history inc_append_history

setopt check_jobs nohup
setopt nobeep nonomatch

if [[ `whoami` != root ]]; then
	autoload -U compinit
	compinit
	zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
fi

bindkey -e
stty stop undef
ulimit -c 0

bindkey '\e[7~' beginning-of-line
bindkey '\e[8~' end-of-line

# Remove / from wordchars, so ^W kills only one path element at a time.
WORDCHARS=${WORDCHARS/\//}

mkdir -p ${XDG_CACHE_HOME}

# autoload all executable files in $fpath
autoload -U $^fpath/*(.xN:t)
alias rem='rem -qg'
alias w3m='w3m -F -v'

alias grep='egrep'
alias feh="feh -FZ"

# define useful aliases for ls based on which *nix we're on.
case $OSTYPE in
	Linux)
		alias ls='ls --color=auto -FhH' ;;
	FreeBSD|Darwin)
		alias ls='ls -GhHTp' ;;
	*)
		alias ls='ls -FhH' ;;
esac

# and some generic ones.
alias ll='ls -l'
alias la='ls -A'
alias lal='ls -lA'
alias lsd='ls -d'

if [[ -e /etc/debian_version ]]; then
	alias ack="ack-grep -a"
else
	alias ack="ack -a"
fi

if [[ -x `which lessfile 2> /dev/null` ]]; then
	eval `lessfile`
elif [[ -x `which lesspipe 2> /dev/null` ]]; then
	eval `lesspipe`
elif [[ -x `which lesspipe.sh 2> /dev/null` ]]; then
	eval `lesspipe.sh`
fi

if [[ -x `which bsdtar` ]]; then
	   alias tar=bsdtar
fi
if [[ -x `which bsdtar` || $OSTYPE == FreeBSD ]]; then
	   alias unzip="tar xf"
	   alias zip="tar"
fi

# zsh's builtin which is better and faster...
alias which > /dev/null && unalias which

# prompt.zsh: shell prompt.

PROMPT="%B[%n@%m]%~%#%b "
RPROMPT=" %B[%*]%b"
case $TERM in
		xterm*|rxvt*|screen*)
				preexec () {
					CMD=$(sed 's/\\/\\\\/g' <<< "$1")
					print -Pn "\033]0;\\[%n@%m:%~\\] $CMD \007"
				}
				preexec
		;;
esac

sshtmp () {
	  ssh -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null" "$@"
}

sshnew () {
	  ssh -o "StrictHostKeyChecking no" "$@"
}

if [[ `whoami` != root ]]; then
	if [[ -x `which keychain` ]]; then
		eval `keychain --eval -q --dir $XDG_CACHE_HOME/keychain`
		ssh-add -l > /dev/null || ssh-add
	fi
fi
setopt auto_cd auto_pushd pushd_silent chasedots chaselinks
setopt menu_complete no_list_beep
setopt extended_glob glob_dots nonomatch nocase_glob
setopt nohist_beep hist_ignore_all_dups share_history inc_append_history

HISTFILE=$XDG_CACHE_HOME/zsh_history
HISTSIZE=819200
SAVEHIST=819200
setopt check_jobs nohup
setopt cbases csh_junkie_history correct
setopt nobeep

if [[ `whoami` != root ]]; then
	autoload -U compinit
	compinit -d $TMP/zcompdump
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

if [[ -d $ZDOTDIR/zshrc.d/ ]]; then
	for i in $ZDOTDIR/zshrc.d/*.zsh; do
		. $i
	done
fi

if [ `emacs --version|head -n1|cut -d\  -f3|cut -d. -f1` -ge 23 ] && ! pgrep -f -u$LOGNAME "emacs --daemon" > /dev/null; then
	emacs --daemon
fi

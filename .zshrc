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
		eval `keychain --eval -q --dir $HOME/.cache/keychain`
		ssh-add -l > /dev/null
	fi
fi
setopt auto_cd auto_pushd pushd_silent chasedots chaselinks
setopt menu_complete no_list_beep
setopt extended_glob glob_dots nonomatch nocase_glob
setopt nohist_beep hist_ignore_all_dups share_history inc_append_history

HISTFILE=$HOME/.history
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

# Remove / from wordchars, so ^W kills only one path element at a time.
WORDCHARS=${WORDCHARS/\//}

if [[ -d $ZDOTDIR/zshrc.d/ ]]; then
	for i in $ZDOTDIR/zshrc.d/*.zsh; do
		. $i
	done
fi

if ! pgrep -f -u$LOGNAME "emacs --daemon" > /dev/null; then
	emacs --daemon
fi

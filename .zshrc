# vim:ft=sh

. $XDG_CONFIG_HOME/aliases.sh

BASE_PROMPT="%n@%m:%~"
PROMPT="%B$BASE_PROMPT>%b "
TITLE_PROMPT=$BASE_PROMPT
case $TERM in
	xterm*|rxvt*|screen*)
		precmd() { print -Pn "\e]0;$TITLE_PROMPT\a"; }
		preexec() { TITLE_PROMPT="$BASE_PROMPT $1"; }
		;;
esac

HISTFILE=$XDG_CACHE_HOME/zsh_history
HISTSIZE=819200
SAVEHIST=819200
setopt nohist_beep hist_ignore_all_dups share_history inc_append_history

setopt check_jobs nohup
setopt nobeep nonomatch

if [[ `whoami` != root ]]; then
	autoload -U compinit
	compinit -d $XDG_CACHE_HOME/zcompdump
	zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
fi

bindkey -e
stty stop undef
ulimit -c 0

bindkey '\e[7~' beginning-of-line
bindkey '\e[8~' end-of-line

# Remove / from wordchars, so ^W kills only one path element at a time.
WORDCHARS=${WORDCHARS/\//}

if [[ `whoami` != root ]]; then
	if [[ -x `which keychain` ]]; then
		eval `keychain --eval -q --dir $XDG_CACHE_HOME/keychain`
		ssh-add -l > /dev/null || ssh-add
	fi
fi
mkdir -p ${XDG_CACHE_HOME}

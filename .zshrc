# vim:ft=sh

. $XDG_CONFIG_HOME/aliases.sh
. $XDG_CONFIG_HOME/prompt.zsh

HISTFILE=$XDG_CACHE_HOME/zsh_history
HISTSIZE=819200
SAVEHIST=819200
setopt nohist_beep hist_ignore_all_dups share_history inc_append_history

setopt check_jobs nohup
setopt nobeep nonomatch
setopt auto_cd auto_pushd pushd_silent
setopt extended_glob

if [[ "$(id -un)" != root ]]; then
	autoload -U compinit
	compinit -d $XDG_CACHE_HOME/zcompdump
	zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
fi

bindkey -e
stty stop undef
ulimit -c 0

bindkey '\e[7~' beginning-of-line
bindkey '\e[8~' end-of-line
bindkey '\e[3~' delete-char

# Remove / from wordchars, so ^W kills only one path element at a time.
WORDCHARS=${WORDCHARS/\//}

if [[ $OSTYPE = FreeBSD ]]; then
	# FreeBSD pam_ssh doesn't make the agent data available.
	if [[ -n "$SSH_AUTH_SOCK" ]]; then
		printf "SSH_AUTH_SOCK=$SSH_AUTH_SOCK; export SSH_AUTH_SOCK;\nSSH_AGENT_PID=$SSH_AGENT_PID; export SSH_AGENT_PID" > "$HOME/.ssh/agent-$HOSTNAME"
	fi
fi
mkdir -p ${XDG_CACHE_HOME}

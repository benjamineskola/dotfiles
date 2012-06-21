# vim:ft=sh

. $XDG_CONFIG_HOME/aliases.sh

_git_no_changes() { (git diff-index --quiet --cached HEAD --ignore-submodules -- && git diff-files --quiet --ignore-submodules;) >/dev/null 2>&1 }
_git_origin_differs() {
	b=$(git name-rev --name-only HEAD 2>/dev/null)
	r=$(git config "branch.${b}.remote")
	[[ $(git rev-parse ${b} ${r}/${b} 2>&1|sort -u|wc -l|tr -d ' ') != 1 ]]
}
_git_prompt_info() {
	([[ -d .git ]] || git rev-parse --git-dir > /dev/null 2>&1) || return
	b=$(git name-rev --name-only HEAD 2>/dev/null); test -n "$b" && (printf ":$b"; _git_no_changes || printf "!"; _git_origin_differs && printf "?")
}

BASE_PROMPT="%n@%m:%~"
TITLE_PROMPT=$BASE_PROMPT
case $TERM in
	xterm*|rxvt*|screen*)
		precmd() { PROMPT="%B$BASE_PROMPT$(_git_prompt_info)>%b "; print -Pn "\e]0;$TITLE_PROMPT\a"; }
		preexec() { TITLE_PROMPT="$BASE_PROMPT $1"; }
		;;
esac

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
		printf "SSH_AUTH_SOCK=$SSH_AUTH_SOCK; export SSH_AUTH_SOCK;\nSSH_AGENT_PID=$SSH_AGENT_PID; export SSH_AGENT_PID" > "$XDG_CONFIG_HOME/_ssh/agent-$HOSTNAME"
	fi
fi
mkdir -p ${XDG_CACHE_HOME}

unset MAIL
mailpath=(${HOME}/mail/INBOX/new/?"You have new mail in INBOX"
	${HOME}/mail/mendeley/new/?"You have new mail in mendeley"
)

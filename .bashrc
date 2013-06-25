# -*- sh -*-

. $HOME/.environment
. $HOME/.aliases

PS1="\[\033[0;37;1m\]\w\[\033[0m\]> "
if [ -n "$SSH_CLIENT" ]; then
	PS1="\[\033[0;37;1m\]\h\[\033[0m\]:"$PS1
fi

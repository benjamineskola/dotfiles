# -*- sh -*-

. $HOME/.environment
. $HOME/.aliases

PS1="\[\033[01;04m\]\w\[\033[0m\]> "
if [ -n "$SSH_CLIENT" -o -n "$SUDO_USER" ]; then
	PS1="\[\033[01;04m\]\h\[\033[0m\]:"$PS1
fi

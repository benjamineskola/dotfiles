# -*- sh -*-

. $HOME/.environment
. $HOME/.aliases

PS1=$'\E[0;37;1m${PWD/${HOME}/~}>\E[0m '
if [ -n "$SSH_CLIENT" ]; then
	PS1=$'\E[0;37;1m\h\E[0m:'$PS1
fi

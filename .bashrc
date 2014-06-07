# -*- sh -*-

. $HOME/.shrc

PS1="\[\033[01;04m\]\w\[\033[0m\]> "
if [ -n "$SSH_CLIENT" ]; then
	PS1="\[\033[01;04m\]\h\[\033[0m\]:"$PS1
elif [ -n "$SUDO_USER" ]; then
	PS1="\[\033[01;04m\]\u\[\033[0m\]@\[\033[01;04m\]\h\[\033[0m\]:"$PS1
fi
case $TERM in
    xterm*|screen*)
	PS1="\[\033]0;\u@\h:\w\007\]"$PS1
        ;;
esac

# vim:ft=sh
shell=$(which zsh)
if [ -n "$PS1" ]; then
	if [ -x "$shell" ]; then
		SHELL=$shell
		export SHELL
		case $0 in
		-*)
			exec $SHELL -l;;
		*)
			exec $SHELL;;
		esac
	fi
	. $HOME/.zshenv
	. $XDG_CONFIG_HOME/aliases.sh
	PS1='\u@\h:\w> '
fi

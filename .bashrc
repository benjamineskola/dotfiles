# vim:ft=sh
shell=$(which zsh)
if [ -x "$shell" ]; then
	if [ -n "$PS1" ]; then
		SHELL=$shell
		export SHELL
		case $0 in
		-*)
			exec $SHELL -l;;
		*)
			exec $SHELL;;
		esac
	fi
	. ./.zshenv
	. ./.zshrc
fi

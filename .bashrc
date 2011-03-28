ENV=$HOME/.mkshrc
export ENV
for shell in mksh ksh zsh; do
	if [ -x "`which $shell`" -a -n "$PS1" ]; then
		SHELL=`which $shell`
		case $0 in
		-*)
			exec $SHELL -l;;
		*)
			exec $SHELL;;
		esac
	fi
done

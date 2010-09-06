if [ -x `which zsh` -a -n "$PS1" ]; then
	SHELL=`which zsh`
	  case $0 in
	-*)
		exec $SHELL -l;;
	*)
		exec $SHELL;;
	esac
fi

# -*- sh -*-

RC="$HOME/.$(basename "$SHELL")rc"
if [ -e "$RC" ]; then
	. "$RC"
fi

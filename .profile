# -*- sh -*-

RC="$HOME/.$(basename "$SHELL")rc"
if [ -e "$RC" ]; then
	. "$RC"
fi

mkdir -p $XDG_CACHE_HOME

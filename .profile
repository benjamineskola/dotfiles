RC="$HOME/.$(basename "$SHELL")rc"
if [ -x "$RC" ]; then
	. "$RC"
fi

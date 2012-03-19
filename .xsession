# vim:ft=sh
#set -e

. $HOME/.zshenv

setxkbmap -option compose:ralt,ctrl:nocaps gb
xmodmap -e "pointer = 1 8 3 4 5 6 7 2 9 10 11 12 13"

case $HOSTNAME in
	kropotkin)
		xrandr --output DVI-0 --right-of DVI-1
		WRAP=132
		;;
esac

xrdb $XDG_CONFIG_HOME/xdefaults
xset r on
xset b off

urxvtd -q -o -f

urxvtc -title "IRC" -e autossh -t bakunin.subvert.org.uk -- exec irc $HOSTNAME &
urxvtc -title "Mail" -e mutt &
urxvtc -title twitter -e ttytter -rc=$HOME/.private/ttytterrc-twitter -lat=$LAT -long=$LON -wrap=$WRAP &

awesome

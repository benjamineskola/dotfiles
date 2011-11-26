# vim:ft=sh
#set -e
. $HOME/.zshenv

setxkbmap -option compose:ralt,ctrl:nocaps gb

case $HOSTNAME in
	kropotkin)
		xrandr --output DVI-I_2/digital --right-of DVI-I_1/digital
		xmodmap -e "pointer = 1 8 3 4 5 6 7 2 9 10 11 12 13"
		;;
esac

xrdb $XDG_CONFIG_HOME/xdefaults
xset r on
xset b off

urxvtd -q -o -f

urxvtc -title "IRC" -e autossh -t bakunin.subvert.org.uk -- exec irc $HOSTNAME &
urxvtc -title twitter -e nctweet &
urxvtc -title "Mail" -e mutt &

remind -z1 -k'xmessage "%s" &' ~/.reminders &

exec awesome

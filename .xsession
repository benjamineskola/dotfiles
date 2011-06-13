# vim:ft=sh
#set -e
. $HOME/.environment

setxkbmap -option compose:ralt,ctrl:nocaps gb

eval `keychain --eval --dir $XDG_CACHE_HOME/keychain`
ssh-add -l > /dev/null || ssh-add

case $HOSTNAME in
	kropotkin)
		xrandr --output DVI-I_2/digital --right-of DVI-D_1
		xmodmap -e "pointer = 1 8 3 4 5 6 7 2 9 10 11 12 13"
		;;
esac

xrdb $XDG_CONFIG_HOME/xdefaults
xset r on
xset b off

urxvtd -q -o -f

if [ $HOSTNAME = "kropotkin" ]; then
	# work
	LAT=51.5223
	LON=-0.10985
else
	# probably laptop, use home coords.
	LAT=51.547
	LON=-0.0303
fi

urxvtc -title "IRC" -e autossh -t jagger.subvert.org.uk -- 'exec \$SHELL -ic "exec\ irc\ $(hostname|cut -d. -f1)"' &
urxvtc -title twitter   -e ttytter -rc=$HOME/.private/ttytterrc-twitter -lat=$LAT -long=$LON &
urxvtc -title identi.ca -e ttytter -rc=$HOME/.private/ttytterrc-identica -lat=$LAT -long=$LON &
urxvtc -title "Mail" -e mutt &
urxvtc -title "News" -e emacs -nw -f gnus &

remind -z1 -k'xmessage "%s" &' ~/.reminders &

exec xmonad

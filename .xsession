# vim:ft=sh
#set -e
. $HOME/.environment

setxkbmap -option compose:ralt,ctrl:nocaps gb

eval `keychain --eval --dir $XDG_CACHE_HOME/keychain`
ssh-add -l > /dev/null || ssh-add

case $HOSTNAME in
	murphy|bma-desktop)
		xmodmap -e "pointer = 1 8 3 4 5 6 7 2 9 10 11 12 13"
		XID=`xinput list|grep Logitech|awk '/pointer/{sub(/^.*id=/,""); sub(/[ \t].*$/, ""); print}'`
		if [ "x$XID" != "x" ]; then
			xinput set-prop $XID "Evdev Wheel Emulation Button" 9
			xinput set-prop $XID "Evdev Wheel Emulation" 254
			xinput set-prop $XID "Evdev Wheel Emulation Inertia" 10
		fi
		;;
	page)
		synclient TapButton1=1 TapButton2=1 TapButton3=1
		;;
esac

xset r on
unclutter &

while true; do urxvtd -q -o; done &
while ! pgrep urxvtd; do sleep 0.1; done

urxvtc -title "IRC" -e autossh -t jagger.subvert.org.uk -- '$SHELL' -ic irc &
urxvtc -title "Mail" -e $SHELL -ic mutt &
urxvtc -title "identi.ca" -e ttytter -apibase=http://identi.ca/api -authtype=basic -user=bma -ansi -wrap -readline -mentions &
urxvtc -title "twitter" -e ttytter -user=bma -ansi -wrap -readline -mentions &

exec xmonad

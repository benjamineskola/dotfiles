set -e
. $HOME/.zshenv

test -e /usr/local/lib/X11/fonts/terminus-font && xset +fp /usr/local/lib/X11/fonts/terminus-font

setxkbmap -option compose:ralt,ctrl:nocaps gb

eval `keychain --eval`
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
xscreensaver -nosplash &
urxvt -title "IRC" -e autossh -t jagger.subvert.org.uk -- tmux attach &
urxvt -title "Mail" -e mutt &

exec xmonad

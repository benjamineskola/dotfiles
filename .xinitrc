test -e /usr/local/lib/X11/fonts/terminus-font && xset +fp /usr/local/lib/X11/fonts/terminus-font

setxkbmap -option compose:ralt,ctrl:nocaps gb
#echo 'keycode 49 = grave notsign'|xmodmap -

xmodmap -e "pointer = 1 8 3 4 5 6 7 2 9 10 11 12 13"
XID=`xinput list|grep Logitech|awk '/pointer/{sub(/^.*id=/,""); sub(/[ \t].*$/, ""); print}'`
if [ "x$XID" != "x" ]; then
	xinput set-prop $XID "Evdev Wheel Emulation Button" 9
	xinput set-prop $XID "Evdev Wheel Emulation" 254
	xinput set-prop $XID "Evdev Wheel Emulation Inertia" 10
fi

#xrdb $HOME/.config/x11/xresources
xset r on
#randbg
unclutter &
urxvtd -q -o -f
xscreensaver -nosplash &
urxvtc -title "IRC" -e autossh -M 0 -t jagger.subvert.org.uk -- screen -Ux &
urxvtc -title "Jabber" -e autossh -M 0 -t joni.subvert.org.uk -- screen -Ux &
urxvtc -title "Mail" -e mutt &
rem '-kxmessage %s &' -z1 &

exec ion3plus

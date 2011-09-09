# vim:ft=sh
#set -e
. $HOME/.zshenv

setxkbmap -option compose:ralt,ctrl:nocaps gb

eval `keychain --eval --dir $XDG_CACHE_HOME/keychain`
ssh-add -l > /dev/null || ssh-add

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

urxvtc -title "IRC" -e autossh -t jagger.subvert.org.uk -- 'exec \$SHELL -ic "exec\ irc\ $HOSTNAME"' &
urxvtc -title twitter   -e ttytter -rc=$HOME/.private/ttytterrc-twitter -lat=$LAT -long=$LON &
urxvtc -title identi.ca -e ttytter -rc=$HOME/.private/ttytterrc-identica -lat=$LAT -long=$LON &
urxvtc -title "Mail" -e mutt &
urxvtc -title "News" -e emacs -nw -f gnus &

remind -z1 -k'xmessage "%s" &' ~/.reminders &

exec xmonad

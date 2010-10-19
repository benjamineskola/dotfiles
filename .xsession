#!/bin/zsh

test -e /usr/local/lib/X11/fonts/terminus-font && xset +fp /usr/local/lib/X11/fonts/terminus-font

setxkbmap -option compose:ralt,ctrl:nocaps gb
#echo 'keycode 49 = grave notsign'|xmodmap -

eval `keychain --eval`
ssh-add -l > /dev/null || ssh-add

. $HOME/.zshenv

#xrdb $HOME/.config/x11/xresources
xset r on
#randbg
unclutter &
urxvtd -q -o -f
xscreensaver -nosplash &
urxvtc -title "IRC" -e ssh -M 0 -t jagger.subvert.org.uk -- tmux attach &
urxvtc -title "Mail" -e mutt &

exec xmonad

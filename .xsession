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
xscreensaver -nosplash &
urxvt -title "IRC" -e autossh -t jagger.subvert.org.uk -- tmux attach &
urxvt -title "Mail" -e mutt &

exec xmonad

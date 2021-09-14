#!/bin/sh
set -e
launchctl setenv XDG_CONFIG_HOME $HOME/.config
launchctl setenv XDG_DATA_HOME $HOME/Library
launchctl setenv XDG_CACHE_HOME $HOME/Library/Caches
launchctl setenv VIMINIT "let \$MYVIMRC=\"\$XDG_CONFIG_HOME/vim/vimrc\" | source \$MYVIMRC"

if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end
fundle plugin matchai/spacefish
fundle init

set -gx EDITOR vim
set -gx VISUAL $EDITOR

set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/Library
set -gx XDG_CACHE_HOME $HOME/Library/Caches

set -gx LESS -ImRswFX
set -gx LESSHISTFILE $XDG_CACHE_HOME/less_history

set -gx BAT_THEME OneHalfDark

set -gx HOSTNAME (scutil --get ComputerName)

mkdir -p $XDG_CACHE_HOME

source /usr/local/share/chruby/chruby.fish
source /usr/local/share/chruby/auto.fish

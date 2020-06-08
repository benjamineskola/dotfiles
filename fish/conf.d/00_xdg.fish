set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/Library
set -gx XDG_CACHE_HOME $HOME/Library/Caches

mkdir -p $XDG_CACHE_HOME

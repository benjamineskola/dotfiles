set -gx XDG_CONFIG_HOME $HOME/.config

if [ $OS = Darwin ]
    set -gx XDG_DATA_HOME $HOME/Library
    set -gx XDG_CACHE_HOME $HOME/Library/Caches
    set -gx XDG_STATE_HOME $HOME/Library
else
    set -gx XDG_DATA_HOME $HOME/.local/share
    set -gx XDG_CACHE_HOME $HOME/.cache
    set -gx XDG_STATE_HOME $HOME/.local/state
end

mkdir -p $XDG_CACHE_HOME

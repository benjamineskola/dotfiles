set -gx XDG_CONFIG_HOME $HOME/.config

if [ (uname -s) = Darwin ]
    set -gx XDG_DATA_HOME $HOME/Library
    set -gx XDG_CACHE_HOME $HOME/Library/Caches
else
    set -gx XDG_DATA_HOME $HOME/.local
    set -gx XDG_CACHE_HOME $HOME/.cache
end

mkdir -p $XDG_CACHE_HOME

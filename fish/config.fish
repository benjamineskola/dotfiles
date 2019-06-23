set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/Library
set -gx XDG_CACHE_HOME $HOME/Library/Caches

set -gx BAT_THEME OneHalfDark
set -gx BUNDLER_CACHE_HOME $XDG_CACHE_HOME/bundler
set -gx BUNDLER_USER_HOME $XDG_CONFIG_HOME/bundler
set -gx EDITOR vim
set -gx HOSTNAME (scutil --get ComputerName)
set -gx LESS -ImRswFX
set -gx LESSHISTFILE $XDG_CACHE_HOME/less_history
set -gx PATH ~/bin $PATH
set -gx PYTHONSTARTUP $XDG_CONFIG_HOME/python/startup.py
set -gx VIMINIT 'let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
set -gx VISUAL $EDITOR

mkdir -p $XDG_CACHE_HOME

source /usr/local/share/chruby/chruby.fish
chruby ruby 2

if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
    sh "$BASE16_SHELL/scripts/base16-materia.sh"
end

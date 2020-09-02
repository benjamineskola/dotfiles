set -x BUNDLE_USER_CACHE "$XDG_CACHE_HOME/bundler"
set -x BUNDLE_USER_HOME "$XDG_CONFIG_HOME/bundler"

set -x EDITOR vimr
set -x VISUAL nvim
set -x LESS -ImRswFX
set -x LESSHISTFILE "$XDG_CACHE_HOME/less_history"
set -x NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npmrc"
set -x PYTHONSTARTUP "$XDG_CONFIG_HOME/python/startup.py"
set -x GOPATH "$HOME/Code/go"

set -a fish_user_paths ~/bin
set -a fish_user_paths /Applications/Postgres.app/Contents/Versions/12/bin
set -a fish_user_paths $GOPATH/bin

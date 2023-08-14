# shellcheck shell=ksh
export XDG_CONFIG_HOME=$HOME/.config
if [[ $OSTYPE == darwin* ]]; then
	export XDG_DATA_HOME=$HOME/Library
	export XDG_CACHE_HOME=$HOME/Library/Caches
	export XDG_STATE_HOME=$HOME/Library

	eval "$(/opt/homebrew/bin/brew shellenv)"
else
	export XDG_DATA_HOME=$HOME/.local/share
	export XDG_CACHE_HOME=$HOME/.cache
	export XDG_STATE_HOME=$HOME/.local/state
fi

mkdir -p "$XDG_CACHE_HOME"

if [[ $OSTYPE == darwin* ]]; then
	export HOMEBREW_BUNDLE_FILE=$XDG_CONFIG_HOME/Brewfile

	# Secretive Config
	export SSH_AUTH_SOCK=/Users/ben/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
fi

export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundler"
export BUNDLE_USER_HOME="$XDG_CONFIG_HOME/bundler"

export EDITOR=hx

export LESS="-ImRswFX --mouse"
export LESSHISTFILE="$XDG_CACHE_HOME/less_history"
export MANPAGER='col -bx | bat -l man -p'

export CARGO_HOME=$XDG_DATA_HOME/cargo
export CARGO_INSTALL_ROOT=$CARGO_HOME
export GOPATH=$XDG_DATA_HOME/go
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npmrc"
export PYENV_ROOT=$XDG_DATA_HOME/pythons
export RUBIES_DIR=$XDG_DATA_HOME/rubies
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export TFENV_CONFIG_DIR="$XDG_DATA_HOME/tfenv"
export YARN_PREFIX=$XDG_DATA_HOME/yarn

export ANSIBLE_HOME=$XDG_CONFIG_HOME/ansible
export ANSIBLE_CONFIG=$ANSIBLE_HOME/ansible.cfg

export VIMINIT="let \$MYVIMRC='$XDG_CONFIG_HOME/vim/vimrc' | source \$MYVIMRC"

path=(~/bin "$CARGO_HOME/bin" "$GOPATH/bin" "$YARN_PREFIX/bin" /usr/local/*bin "${path[@]}")

if [[ -d $RUBIES_DIR ]]; then
	# shellcheck source=/dev/null
	source "$HOMEBREW_PREFIX/opt/chruby/share/chruby/chruby.sh"
	export RUBIES=("$RUBIES_DIR"/ruby-*)
fi

if type fnm >/dev/null; then
	eval "$(fnm env --version-file-strategy recursive)"
fi

eval "$(pyenv init -)"

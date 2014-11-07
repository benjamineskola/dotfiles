# -*- sh -*-

. $HOME/.zsh/prompt.zsh

case $TERM in
    xterm*|screen*)
        print -Pn "\e]0;%n@%m:%~\a"
        preexec () { print -Pn "\e]0;%n@%m:%~> $1\a" }
        ;;
esac

HISTFILE=$XDG_CACHE_HOME/zsh_history
HISTSIZE=819200
SAVEHIST=819200
setopt nohist_beep hist_ignore_all_dups share_history inc_append_history
setopt check_jobs
setopt nobeep nonomatch
setopt auto_cd auto_pushd pushd_silent
setopt extended_glob
setopt correct

bindkey -e

## Completions
autoload -U compinit
compinit -d $XDG_CACHE_HOME/zcompdump

## case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

. /usr/local/share/chruby/chruby.sh
. /usr/local/share/chruby/auto.sh

chef-init() {
	eval "$(/opt/chefdk/bin/chef shell-init zsh)"
}

chef-deinit() {
	unset GEM_ROOT GEM_PATH GEM_HOME
	for i in {$#path..1}; do
		if [ "$path[$i]" =~ chefdk ]; then
			path[$i]=()
		fi
	done
}

mkdir -p $XDG_CACHE_HOME

test -e ~/.zsh/aliases && . ~/.zsh/aliases
test -e ~/.zsh/$OS/aliases && . ~/.zsh/$OS/aliases
test -e ~/.zsh/aliases.after && . ~/.zsh/aliases.after

if [[ "$TERM" == "dumb" ]]; then
  unset RPROMPT
  PROMPT='$ '
fi

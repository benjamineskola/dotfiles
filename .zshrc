# -*- sh -*-

. $HOME/.environment
. $HOME/.aliases

PS1='%B%U%~>%u%b '
if [ -n "$SSH_CLIENT" -o -n "$SUDO_USER" ]; then
	PS1='%B%U$HOSTNAME%u%b:'$PS1
fi
HISTFILE=$XDG_CACHE_HOME/zsh_history
HISTSIZE=819200
SAVEHIST=819200
setopt nohist_beep hist_ignore_all_dups share_history inc_append_history

bindkey -e

## Completions
autoload -U compinit
compinit -d $XDG_CACHE_HOME/zcompdump

## case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

setopt autolist

eval "$(rbenv init -)"

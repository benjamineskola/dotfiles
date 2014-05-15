# -*- sh -*-

. $HOME/.environment
. $HOME/.aliases

PROMPT='%B%U%~>%u%b '
if [ -n "$SSH_CLIENT" ]; then
	PROMPT='%B%U%m%u%b:'$PROMPT
elif [ -n "$SUDO_USER" ]; then
	PROMPT='%B%U%n%u%b@%B%U%m%u%b:'$PROMPT
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

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

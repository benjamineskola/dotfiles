# -*- sh -*-

. $HOME/.shrc

PROMPT='%B%U%~>%u%b '
if [ -n "$SSH_CLIENT" ]; then
	PROMPT='%B%U%m%u%b:'$PROMPT
elif [ -n "$SUDO_USER" ]; then
	PROMPT='%B%U%n%u%b@%B%U%m%u%b:'$PROMPT
fi
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

if [ $(whoami) != root ]; then
	if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
fi

# -*- sh -*-

OS=${OSTYPE%%[0-9.]*}

for file in environment aliases; do
    cd $HOME/.zsh
    test -e $file && . ./$file
    test -e $OS/$file && . ./$OS/$file
    test -e $file.after && . ./$file.after
    cd - > /dev/null
done

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

mkdir -p $XDG_CACHE_HOME

if [[ "$TERM" == "dumb" ]]; then
  unset RPROMPT
  PROMPT='$ '
fi

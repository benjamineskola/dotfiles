# vim:ft=zsh

. ~/.aliases

HISTFILE=$XDG_CACHE_HOME/zsh_history
HISTSIZE=819200
SAVEHIST=819200

setopt nohist_beep hist_ignore_all_dups share_history

## Completions
autoload -U compinit
compinit -u -d "$XDG_CACHE_HOME/zcompdump"

## case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# don't include random latex output in completion for editors.
zstyle ':completion:*:*:(vi(m|)|emacs(client|)|subl|atom):*:*files' ignored-patterns '*.(aux|dvi|log|ps|pdf|bbl|toc|lot|lof|bcf|blg|fdb_latexmk|fls|run.xml|out)'

# specific completion for custom git functions
compdef _git-branch gbr

WORDCHARS=${WORDCHARS/\//}

. /usr/local/share/chruby/chruby.sh
. /usr/local/share/chruby/auto.sh
chruby $(cat ~/.ruby-version)

setopt check_jobs
setopt nobeep
setopt auto_cd auto_pushd pushd_silent
setopt extended_glob glob_dots
setopt correct
setopt nonomatch

bindkey -e

mkdir -p "$XDG_CACHE_HOME"

## Prompt

case $TERM in
    xterm*|screen*)
        print -Pn "\e]0;%n@%m:%~\a"
        preexec () { print -Pn "\e]0;%n@%m:%~> $1\a"; }
        ;;
esac

function vcs_info {
       _vcs_info=''
       git branch >/dev/null 2>&1 && _vcs_info=" %F{cyan}%F{magenta}${$(git symbolic-ref HEAD)#refs/heads/}%f"
}

autoload add-zsh-hook
add-zsh-hook precmd vcs_info

setopt prompt_subst
PROMPT='[%(!.%F{red}%n .)%f%F{green}${${:-${${${(@j:/:M)${(@s:/:)${(%):-%~}}##.#?}:h}%/}/}#./}${${(%):-%1~}#/}%f${_vcs_info}]%0(?.%F{green}✓.%F{red}✗)%f '

## syntax
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

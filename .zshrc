# -*- sh -*-

case $TERM in
    xterm*|screen*)
        print -Pn "\e]0;%n@%m:%~\a"
        preexec () { print -Pn "\e]0;%n@%m:%~> $1\a" }
        ;;
esac

function vcs_info {
	_vcs_info=''
	hg root >/dev/null 2>&1 && _vcs_info=" %F{cyan}hg:%F{magenta}$(hg branch)%f"
	git branch >/dev/null 2>&1 && _vcs_info=" %F{cyan}git:%F{magenta}${$(git symbolic-ref HEAD)#refs/heads/}%f"
}

autoload add-zsh-hook
add-zsh-hook precmd vcs_info

setopt prompt_subst
PROMPT='[%F{blue}%n%f@%F{yellow}%m%f %F{green}${${:-${${${(@j:/:M)${(@s:/:)${(%):-%~}}##.#?}:h}%/}/}#./}${${(%):-%1~}#/}%f${_vcs_info}] %0(?.%F{green}✓.%F{red}✗)%f '

HISTFILE=$XDG_CACHE_HOME/zsh_history
HISTSIZE=819200
SAVEHIST=819200
setopt nohist_beep hist_ignore_all_dups share_history inc_append_history
setopt check_jobs
setopt nobeep
setopt auto_cd auto_pushd pushd_silent
setopt extended_glob glob_dots
setopt correct

bindkey -e

## Completions
autoload -U compinit
compinit -d $XDG_CACHE_HOME/zcompdump

## case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# don't include random latex output in completion for editors.
zstyle ':completion:*:*:(vi(m|)|emacs(client|)|subl):*:*files' ignored-patterns '*.(aux|dvi|log|ps|pdf|bbl|toc|lot|lof|bcf|blg|fdb_latexmk|fls|run.xml|out)'

mkdir -p $XDG_CACHE_HOME

WORDCHARS=${WORDCHARS/\//}

test -e ~/.zsh/aliases && . ~/.zsh/aliases
test -e ~/.zsh/$OS/aliases && . ~/.zsh/$OS/aliases
test -e ~/.zsh/aliases.after && . ~/.zsh/aliases.after

if [[ "$TERM" == "dumb" ]]; then
  unset RPROMPT
  PROMPT='$ '
fi

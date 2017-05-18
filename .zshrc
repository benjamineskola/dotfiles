# -*- zsh -*-

alias be='bundle exec'
alias curl='curl -gkLsS'
alias dc="dc -e '2k' -f /dev/stdin"
alias grep=egrep
alias puppet-lint='puppet-lint --with-filename'
alias tf="tail -F"

alias ag='ag --pager less --hidden --ignore .git --ignore .hg -ai'
alias fetch='command curl -gkLO'


if [[ -e "$(which colordiff)" ]]; then
	alias diff='colordiff -u'
	alias colordiff='colordiff -u'
else
	alias diff='diff -u'
fi

if [[ -e "$(which service)" ]]; then
	alias service='command sudo service'
else
	alias service='command sudo invoke-rc.d'
fi

if [[ -e "$(which vim)" ]]; then
	alias vi=vim
fi

alias g="git"
alias gadd="git add"
alias gaddp="env GIT_EDITOR=vi git add -p"
alias gamend="git commit --amend -CHEAD"
alias gbr="git branch -a"
alias gco="git checkout"
alias gci="git commit"
alias gclone="git clone"
alias gd="git diff -M"
alias gdc="git diff -M --cached"
alias gl="git log -M --graph --decorate --abbrev-commit"
alias gmerge="git merge"
alias gnew="git checkout -b"
alias gnuke="git reset --hard"
alias gp="git push"
alias greb="env GIT_EDITOR=vi git rebase"
alias grm="git rm"
alias gsh="git show"
alias gst="git status -sb"
alias gundo="git checkout HEAD -- "
alias gundop="git checkout -p -- "
alias gup="git up"

path+=/usr/local/Cellar/git/${${(%):-"$(command git --version)"}#* * }/share/git-core/contrib/diff-highlight

alias ls='ls -GhHpT'
alias ll='ls -l'
alias la='ls -A'
alias lal='ls -lA'
alias lsd='ls -d'

HISTFILE=$XDG_CACHE_HOME/zsh_history
HISTSIZE=819200
SAVEHIST=819200

setopt nohist_beep hist_ignore_all_dups share_history inc_append_history

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
       hg root >/dev/null 2>&1 && _vcs_info=" %F{cyan}hg:%F{magenta}$(hg branch 2> /dev/null)%f"
       git branch >/dev/null 2>&1 && _vcs_info=" %F{cyan}%F{magenta}${$(git symbolic-ref HEAD)#refs/heads/}%f"
}

function ruby_info {
       _ruby_info=" ${${${$(ruby --version)##ruby }%% *}%%p*}"
}

autoload add-zsh-hook
add-zsh-hook precmd vcs_info
add-zsh-hook precmd ruby_info

setopt prompt_subst
PROMPT='[%(!.%F{red}.%F{blue})%n%f@%F{yellow}%m%f %F{green}${${:-${${${(@j:/:M)${(@s:/:)${(%):-%~}}##.#?}:h}%/}/}#./}${${(%):-%1~}#/}%f${_vcs_info}${_ruby_info}]%0(?.%F{green}✓.%F{red}✗)%f '

## syntax
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# shellcheck shell=ksh

autoload -Uz compinit

# shellcheck disable=SC2144,SC2157
if [[ -n ${XDG_CACHE_HOME}/zcompdump*(N.mh+24) ]]; then
	compinit -u -d "$XDG_CACHE_HOME/zcompdump"
else
	compinit -u -d "$XDG_CACHE_HOME/zcompdump" -C
fi
# shellcheck source=/dev/null
. /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load "$XDG_CONFIG_HOME/zsh/plugins.txt"

alias curl='curl -gLsS --compressed'

alias fdd='fd .'
alias fdg='fd -g'
alias fetch='curl -gkLO'
alias grep=egrep
if whence -p hexyl >/dev/null; then alias hd=hexyl; else alias hd='hexdump -Cvv'; fi
alias less=bat
alias psed='perl -0777 -p -e'
whence -p rg >/dev/null || alias rg='grep -ri'
alias sed='sed -E'
alias tf='tail -F'
alias mdless='mdless --width 72'
alias eza='eza --git -b'

whence -p eza >/dev/null && alias ls=eza
alias ll='ls -l'
alias la='ls -a'
alias lal='ls -la'
alias lsd='ls -d'

alias vi=hx
alias vim=hx
alias nvim=hx
alias neovide=hx

alias listcops='rubocop -fo'
alias openports='lsof -nP -iTCP -sTCP:LISTEN'
alias fontname='fc-scan --format "%{postscriptname}\n"'
alias ruby-install="ruby-install -r '\$RUBIES_DIR -s '\$RUBY_TMP'"

alias dj='python manage.py'
alias djs='dj shell_plus'
alias djrs='dj runserver'
alias djmm='dj makemigrations'
alias djm='dj migrate'
alias djcsu='dj createsuperuser'

alias gfu=git-fixup
alias gl=glgg
alias glgp='glg -p --pretty=medium'
alias gmv='git mv'
alias grsp='grs -p'
alias gswm=gcm
alias gmt='git mergetool'
# alias gs='fish_command_not_found gs' # i never want ghostscript

setopt AUTO_CD AUTO_PUSHD

if [[ $OSTYPE == darwin* ]]; then
	fpath+=("$HOMEBREW_PREFIX/share/zsh/site-functions") # in case this is system zsh not homebrew
fi

eval "$(zoxide init zsh)"

if [[ -d $RUBIES_DIR ]]; then
	# shellcheck source=/dev/null
	source "$HOMEBREW_PREFIX/opt/chruby/share/chruby/auto.sh"
fi

if type fnm >/dev/null; then
	eval "$(fnm env --use-on-cd --version-file-strategy recursive)"
fi

bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

setopt SHARE_HISTORY EXTENDED_HISTORY HIST_IGNORE_DUPS
HISTFILE=$XDG_CACHE_HOME/zsh_history
HISTSIZE=999999999
# shellcheck disable=SC2034
SAVEHIST=$HISTSIZE

setopt RC_EXPAND_PARAM
fpath+=("$XDG_CONFIG_HOME/zsh/functions.zwc")
# shellcheck disable=SC2296,SC2086
autoload -U ${fpath%.zwc}/*(.N:t)
zrecompile -p "$XDG_CONFIG_HOME/zsh/functions.zwc" "$XDG_CONFIG_HOME"/zsh/functions/*
setopt NO_RC_EXPAND_PARAM

eval "$(direnv hook zsh)"

export FZF_DEFAULT_OPTS='--cycle --layout=reverse --border --height=90% --preview-window=wrap'
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS --preview=\"echo '\'{}\'' | cut -f 2 | xargs eza -l\""
# shellcheck source=/dev/null
. "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"

zle -N _fzf_cd_widget
zle -N _fzf_find_file_widget
zle -N _fzf_branch_picker_widget

bindkey '\ec' _fzf_cd_widget
bindkey '\eo' _fzf_find_file_widget
bindkey '\eg' _fzf_branch_picker_widget

WORDCHARS=${WORDCHARS/\//}

prompt_pure_set_title() { :; }
title_idle() {
	PWD2=${PWD/$HOME/~}
	print -Pn "\e]0;${PWD2##*/}\a"
}
title_active() {
	PWD2=${PWD/$HOME/~}
	print -Pn "\e]0;${1//(caffeinate|sudo|doas) /}: ${PWD2##*/}\a"
}

autoload -U add-zsh-hook
add-zsh-hook precmd title_idle
add-zsh-hook preexec title_active

# case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

setopt PROMPT_SUBST

eval "$(starship init zsh)"

__git_prompt_git() { git "$@"; }

# shellcheck disable=SC2034
PERIOD=60
periodic_git_fetch() {
	command git rev-parse --is-inside-work-tree &>/dev/null || return 0

	(git fetch --all -p &) >/dev/null 2>&1
}
add-zsh-hook periodic periodic_git_fetch
add-zsh-hook chpwd periodic_git_fetch

TMOUT=5
TRAPALRM() {
	if [[ $BUFFER != "" && $WIDGET != "" && $WIDGET != "accept-line" ]]; then
		return 0
	fi

	res="$(command git rev-parse --is-inside-work-tree 2>/dev/null </dev/tty)"
	test "$res" = "true" || return 0

	local_head=$(git rev-parse HEAD 2>/dev/null)
	remote_head=$(git rev-parse "@{u}" 2>/dev/null)
	if [[ $__GIT_LAST_REMOTE != "$remote_head" ]] ||
		[[ $__GIT_LAST_HEAD != "$local_head" ]] ||
		{ [[ $local_head == "$remote_head" ]] && [[ $__GIT_LAST_REMOTE != "$local_head" ]]; }; then
		zle reset-prompt
		__GIT_LAST_HEAD=$local_head
		__GIT_LAST_REMOTE=$remote_head
	fi
}

__GIT_LAST_HEAD=""
__GIT_LAST_REMOTE=""
save_git_info() {
	__GIT_LAST_HEAD=$(git rev-parse HEAD 2>/dev/null)
	__GIT_LAST_REMOTE=$(git rev-parse "@{u}" 2>/dev/null)
}
add-zsh-hook chpwd save_git_info
save_git_info

# -*- sh -*-
autoload colors; colors

setopt prompt_subst

function in_home_subdir {
	if [[ "$(hg root 2>/dev/null)" == $HOME && "$PWD" =~ "$HOME/[A-Za-z0-9]" ]]; then
		return 1
	else
		return 0
	fi
}
# from http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/
function prompt_char {
	if in_home_subdir; then
		#[[ $PWD =~ "$HOME/[A-Za-z0-9]" ]] && continue
		hg root >/dev/null 2>&1 && echo '☿' && return
	fi
	git branch >/dev/null 2>&1 && echo '±' && return
	echo '○'
}

function hg_prompt_info {
	in_home_subdir || return
	hg prompt --angle-brackets " <on %{$fg[magenta]%}<branch>%{$reset_color%}><%{$fg[green]%}<status>%{$reset_color%}><%{$fg[green]%}<update>%{$reset_color%}>" 2>/dev/null
}

# from https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/git.zsh
function git_prompt_info {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

parse_git_dirty () {
  gitstat=$(git status 2>/dev/null | egrep '^(Untracked|Changes|Changed but not updated:)')

  if [[ $(echo ${gitstat} | egrep -c "^Changes to be committed:$") > 0 ]]; then
	echo -n "$ZSH_THEME_GIT_PROMPT_DIRTY"
  fi

  if [[ $(echo ${gitstat} | egrep -c "^(Untracked files:|Changed but not updated:|Changes not staged for commit:)$") > 0 ]]; then
	echo -n "$ZSH_THEME_GIT_PROMPT_UNTRACKED"
  fi

  if [[ $(echo ${gitstat} | egrep -v '^$' | wc -l | tr -d ' ') == 0 ]]; then
	echo -n "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

PROMPT='
%{$fg[blue]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} in %{$fg[green]%}${PWD/#$HOME/~}%b%{$reset_color%}$(git_prompt_info)$(hg_prompt_info)
$(prompt_char) '
RPROMPT='%(?..%{$fg[red]%}✗%{$reset_color%}) [$(date +%H:%M:%S)]'

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

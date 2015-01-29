# -*- sh -*-
autoload colors; colors

setopt prompt_subst

function in_home_subdir {
	if [[ "$(git rev-parse --show-toplevel 2>/dev/null)" == $HOME && "$PWD" =~ "$HOME/[A-Za-z0-9]" ]]; then
		return 1
	else
		return 0
	fi
}
# from http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/
function prompt_char {
	if in_home_subdir; then
		#[[ $PWD =~ "$HOME/[A-Za-z0-9]" ]] && continue
		git branch >/dev/null 2>/dev/null && echo '±' && return
	fi
	echo '○'
}

# from https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/git.zsh
function git_prompt_info {
	in_home_subdir || return
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

chef_prompt_info () {
	if [[ $(which ruby) =~ chefdk ]]; then
		echo -n '🍴'
	fi
}

PROMPT='
%{$fg[blue]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} in %{$fg[green]%}${PWD/#$HOME/~}%b%{$reset_color%}$(git_prompt_info)$(chef_prompt_info)
$(prompt_char) '
RPROMPT='%(?..%{$fg[red]%}✗%{$reset_color%})'

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

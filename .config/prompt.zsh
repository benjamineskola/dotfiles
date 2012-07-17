autoload -U colors && colors

virtualenv_info() {
	[ $VIRTUAL_ENV ] && echo "($(basename $VIRTUAL_ENV))"
}
parse_git_dirt() {
	local SUBMODULE_SYNTAX=''
	if [[ $POST_1_7_2_GIT -gt 0 ]]; then
		SUBMODULE_SYNTAX="--ignore-submodules=dirty"
	fi
	if [[ -n $(git status -s ${SUBMODULE_SYNTAX}  2> /dev/null) ]]; then
		echo "!"
	fi
}
git_prompt_info() {
	ref=$(git symbolic-ref HEAD 2> /dev/null)  || return
	if [[ $(git rev-parse --git-dir) = $HOME/.git ]]; then
		if [[ $PWD != $HOME/.config && $PWD != $HOME/bin ]]; then
			return
		fi
	fi
	echo ":%{$fg[magenta]%}${ref#refs/heads/}%{$fg[green]%}$(parse_git_dirty)%{$reset_color%}"
}

TITLE_PROMPT="[%n@%m:${PWD/#$HOME/~}]"
case $TERM in
	xterm*|rxvt*|screen*)
		precmd() {
			PROMPT="
%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%}:%{$fg[green]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info)
$(virtualenv_info)> "
			print -Pn "\e]0;$TITLE_PROMPT\a";
		}
		preexec() {
			TITLE_PROMPT="[%n@%m:$(collapse_pwd)] $1"
		}
		;;
esac


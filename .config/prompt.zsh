virtualenv_info() {
	[ $VIRTUAL_ENV ] && echo "($(basename $VIRTUAL_ENV))"
}
collapse_pwd() {
	echo $(pwd | sed -e "s,^$HOME,~,")
}
parse_git_dirty() {
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
	echo ":${ref#refs/heads/}$(parse_git_dirty)"
}

TITLE_PROMPT="[%n@%m:$(collapse_pwd)]"
case $TERM in
	xterm*|rxvt*|screen*)
		precmd() {
			PROMPT="
%B%n@%m:$(collapse_pwd)$(git_prompt_info)
$(virtualenv_info)>%b "
			print -Pn "\e]0;$TITLE_PROMPT\a";
		}
		preexec() {
			TITLE_PROMPT="[%n@%m:$(collapse_pwd)] $1"
		}
		;;
esac


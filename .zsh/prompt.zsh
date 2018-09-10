case $TERM in
    xterm*|screen*)
        print -Pn "\e]0;%~\a"
	preexec () { print -Pn "\e]0;%~ ${1[(w)1]}\a"; }
        ;;
esac

function vcs_info {
	_git_ref=$(command git symbolic-ref HEAD 2> /dev/null) ||
	_git_ref=$(command git rev-parse --short HEAD 2> /dev/null) ||
	return 0
	_vcs_info=" git:%F{cyan}${_git_ref#refs/heads/}%f"

	_git_status=$(command git status --porcelain --untracked-files=no 2> /dev/null)
	if [[ -z "${_git_status}" ]]; then
	       _vcs_info+=" %F{green}o%f"
	else
	       _vcs_info+=" %F{red}x%f"
	fi
}

autoload add-zsh-hook
add-zsh-hook precmd vcs_info

setopt prompt_subst
PROMPT='[%(!.%F{red}%n%f in .)%f%F{green}${${:-${${${(@j:/:M)${(@s:/:)${(%):-%~}}##.#?}:h}%/}/}#./}${${(%):-%1~}#/}%f${_vcs_info}]%0(?.%F{green}✓.%F{red}✗)%f '

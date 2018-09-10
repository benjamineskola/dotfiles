case $TERM in
    xterm*|screen*)
        print -Pn "\e]0;%~\a"
	preexec () { print -Pn "\e]0;%~ ${1[(w)1]}\a"; }
        ;;
esac

function vcs_info {
	_vcs_info=" git:%F{cyan}$(git-current-branch)%f"

	if git-is-clean; then
	       _vcs_info+=" %F{green}o%f"
	else
	       _vcs_info+=" %F{red}x%f"
	fi
}

autoload add-zsh-hook
add-zsh-hook precmd vcs_info

setopt prompt_subst
PROMPT='
[%(!.%F{red}%n%f in .)%f\
%F{green}${${:-${${${(@j:/:M)${(@s:/:)${(%):-%~}}##.#?}:h}%/}/}#./}${${(%):-%1~}#/}%f\
${_vcs_info}]\
%(?.. C:%F{red}%?%f)
$ '

case $TERM in
    xterm*|screen*)
        print -Pn "\e]0;%~\a"
	preexec () { print -Pn "\e]0;%~ ${1[(w)1]}\a"; }
        ;;
esac

autoload add-zsh-hook
add-zsh-hook precmd git_prompt_info

setopt prompt_subst
PROMPT='
[%(!.%F{red}%n%f in .)%f\
%F{green}${${:-${${${(@j:/:M)${(@s:/:)${(%):-%~}}##.#?}:h}%/}/}#./}${${(%):-%1~}#/}%f\
${_vcs_info}]\
%(?.. C:%F{red}%?%f)
$ '

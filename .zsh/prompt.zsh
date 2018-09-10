case $TERM in
    xterm*|screen*)
        print -Pn "\e]0;%~\a"
	preexec () { print -Pn "\e]0;%~ ${1[(w)1]}\a"; }
        ;;
esac

function vcs_info {
       _vcs_info=''
       git branch >/dev/null 2>&1 && _vcs_info=" git:%F{cyan}${$(git symbolic-ref HEAD)#refs/heads/}%f"
}

autoload add-zsh-hook
add-zsh-hook precmd vcs_info

setopt prompt_subst
PROMPT='[%(!.%F{red}%n%f in .)%f%F{green}${${:-${${${(@j:/:M)${(@s:/:)${(%):-%~}}##.#?}:h}%/}/}#./}${${(%):-%1~}#/}%f${_vcs_info}]%0(?.%F{green}✓.%F{red}✗)%f '

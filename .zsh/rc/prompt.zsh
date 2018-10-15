case $TERM in
    xterm*|screen*)
        print -Pn "\e]0;%~\a"
	preexec () { print -Pn "\e]0;%~ ${1[(w)1]}\a"; }
        ;;
esac

# Git info
local git_info='$(git_prompt_info)'
local _vcs_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX=" git:%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}x"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}o"

setopt prompt_subst
PROMPT="
[%(!.%F{red}%n%f in .)%f\
%F{green}${${:-${${${(@j:/:M)${(@s:/:)${(%):-%~}}##.#?}:h}%/}/}#./}${${(%):-%1~}#/}%f\
${_vcs_info}]\
%(?.. C:%F{red}%?%f)
$ "

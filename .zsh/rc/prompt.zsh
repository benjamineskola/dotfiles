# Git info
local _vcs_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX=" git:%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}x"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}o"

setopt prompt_subst
PROMPT='
[%(!.%F{red}%n%f in .)%f'
PROMPT+='%F{green}${${:-${${${(@j:/:M)${(@s:/:)${(%):-%~}}##.#?}:h}%/}/}#./}${${(%):-%1~}#/}%f'
PROMPT+="${_vcs_info}]"
PROMPT+='%(?.. C:%F{red}%?%f)
$ '

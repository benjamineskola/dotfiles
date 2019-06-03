# vim:ft=zsh

alias curl='curl -gkLsS'
alias dc="dc -e '2k' -f /dev/stdin"
alias grep=egrep
alias tf="tail -F"

alias ag=rg
alias rg='rg --hidden -g "!.git"'
alias fetch='command curl -gkLO'

preferred-alias less bat

alias exa='exa --git -b'
alias ls='ls -GhHpT'
preferred-alias ls exa

alias ll='ls -l'
alias la='ls -a'
alias lal='ls -la'
alias lsd='ls -d'

ducks() {
  du -csh "$@" | gsort -rh
}

if [[ -f =bat ]]; then
  diff() { command diff -u "$@" | bat -l diff }
else
  alias diff='diff -u'
fi

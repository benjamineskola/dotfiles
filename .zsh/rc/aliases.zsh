# vim:ft=zsh

alias be='bundle exec'
alias curl='curl -gkLsS'
alias dc="dc -e '2k' -f /dev/stdin"
alias grep=egrep
alias tf="tail -F"

alias ag='ag --pager less --hidden --ignore .git --ignore .hg -i'
alias fetch='command curl -gkLO'

preferred-alias less bat

alias ls='ls -GhHpT'
alias ll='ls -l'
alias la='ls -A'
alias lal='ls -lA'
alias lsd='ls -d'

ducks() {
	du -csh "$@" | gsort -rh
}

if [[ -f =bat ]]; then
	diff() { command diff -u "$@" | bat -l diff }
else
	alias diff='diff -u'
fi

alias curl 'command curl -gkLsS'
alias dc "command dc -e '2k' -f /dev/stdin"
alias grep egrep
alias tf "tail -F"

alias ag rg
alias rg 'command rg --hidden -g "!.git"'
alias fetch 'command curl -gkLO'

alias less bat

alias exa 'command exa --git -b'
alias ls 'exa'
alias ll 'ls -l'
alias la 'ls -a'
alias lal 'ls -la'
alias lsd 'ls -d'

function ducks
    du -csh $argv | gsort -rh
end

function diff
    command diff -u $argv | diff-so-fancy
end

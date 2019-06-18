alias curl 'curl -gkLsS'
alias dc "dc -e '2k' -f /dev/stdin"
alias grep egrep
alias tf "tail -F"

alias ag rg
alias fetch 'curl -gkLO'

alias less bat

alias exa 'exa --git -b'
alias ls 'exa'
alias ll 'ls -l'
alias la 'ls -a'
alias lal 'ls -la'
alias lsd 'ls -d'

alias rspec 'caffeinate bundle exec rspec'

function ducks
    du -csh $argv | gsort -rh
end

function diff
    command diff -u $argv | diff-so-fancy
end

function rg --wraps rg
    if isatty stdout
        command rg --heading --color=always $argv | command less
    else
        command rg $argv
    end
end

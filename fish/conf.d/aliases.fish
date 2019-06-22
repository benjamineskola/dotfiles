alias ag rg
alias be 'bundle exec'
alias bi 'bundle install'
alias curl 'curl -gkLsS'
alias fdd 'fd .'
alias fetch 'curl -gkLO'
alias grep egrep
alias less bat
alias rspec 'caffeinate bundle exec rspec'
alias tf 'tail -F'

alias exa 'exa --git -b'
alias ls exa
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

function rg --wraps rg
    if isatty stdout
        command rg --heading --color=always $argv | command less
    else
        command rg $argv
    end
end

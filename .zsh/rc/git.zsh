path+=(/usr/local/Cellar/git/${${(%):-"$(command git --version)"}#* * }*/share/git-core/contrib/diff-highlight(OnY1))

alias gl=glgg
alias gmv='git mv'
alias grm='git rm'


alias gc='git commit --edit -v'
alias gc!='git commit --edit -v --amend'
alias gca='git commit --edit -v -a'
alias gca!='git commit --edit -v -a --amend'
alias gcam='git commit --edit -a -m'

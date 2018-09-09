alias g="git"
git config -l | grep '^alias' | cut -d = -f 1 | cut -d . -f 2 | while read; do alias g$REPLY="git $REPLY"; done
for i in add clone merge rm; do alias g$i="git $i"; done
alias gaddp="git ap"

path+=/usr/local/Cellar/git/${${(%):-"$(command git --version)"}#* * }/share/git-core/contrib/diff-highlight

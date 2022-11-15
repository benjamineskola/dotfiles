function git-fixup
    argparse --name=git-fixup y/yes -- $argv
    or return

    set rev (git rev-parse "$argv[1]")
    set -e argv[1]

    if ! [ $_flag_yes ]
        git show --stat "$rev"
        printf "Fixup? y/N"
        read confirm
        if [ "$confirm" != y ] && [ "$confirm" != Y ]
            return
        end
    end

    if count $argv >/dev/null
        git commit --fixup "$rev" "$argv"
    else
        git commit --fixup "$rev"
    end
    and env GIT_SEQUENCE_EDITOR=cat git rebase -i "$rev^" | grep -v '^#'
end

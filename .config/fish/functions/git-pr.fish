function git-pr
    set url (git config remote.origin.url)
    set branch (git_current_branch)

    if nonempty $argv
        set branch $argv[1]
    end

    if test $branch = 'master'
        echo "Branch is master, can't merge" >&2
        return 1
    end

    if string match '*github*' $url
        if string match '*:*' $url
            set url "https://github.com/"(string replace -r '.*:' '' $url)
            set url (string replace -r '(\.git)?/?$' '' $url)
            set url "$url/pull/new/$branch"
        end
        echo $url
    else
        echo "Not a github url" >&2
        return 1
    end

    open $url
end

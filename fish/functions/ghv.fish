function ghv
    set target $argv[1]
    if ! string match -q "/*" $target
        set target "$PWD/$target"
    end
    if ! test -e "$target"
        echo "no such file or directory $target" >&2
        return 1
    end

    set dir $target
    if ! test -d "$target"
        set dir (cd (dirname $dir); git rev-parse --show-toplevel)
    end

    set branch (cd $dir; git branch --show-current)
    set remote (cd $dir; git remote get-url (cd $dir; git config branch.$branch.remote))
    if string match -q "*:*" $remote
        set _split (string split ":" $remote)
        set url https://github.com/$_split[2]
    end

    if test $target != $dir
        set file (string replace -r "^$dir/?" "" $target)
        set url "$url/tree/$branch/$file"
    end
    open $url
end

function fish_title
    if not test $_ = fish -o $_ = cd
        echo -n "$_: "
    end
    echo (basename (string replace "$HOME" '~' $PWD))
end

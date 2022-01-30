function fish_title
    if not test $_ = fish -o $_ = cd
        if not test $_ = sudo -o $_ = caffeinate
            echo -n "$_: "
        else
            for word in (string split ' ' $argv)
                if ! test "$word" = sudo -o "$word" = caffeinate
                    echo -n "$word: "
                    break
                end
            end
        end
    end
    echo (basename (string replace "$HOME" '~' $PWD))
end

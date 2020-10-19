function fish_title
    if test $_ = fish
        echo (basename (string replace "$HOME" '~' $PWD))
    else
        echo (string replace -r ' .*$' '' $argv[1]):\ (basename (string replace "$HOME" '~' $PWD))
    end
end

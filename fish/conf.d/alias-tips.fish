function print_aliases --on-event fish_preexec
    set subcommands (string split '|' (string replace -r '\s*\|\s*' '|' $argv))

    for subcommand in $subcommands
        set params (string split ' ' $subcommand)
        if test $params[1] = 'g'
            set params git $params[2..-1]
        end

        for i in (seq (count $params) 1)
            if test -z "$params[$i]"
                continue # sometimes we get empty strings
            end

            set match (alias | grep "^alias \w+ '$params[1..$i]'\$")
            if test -n "$match"
                set alias (string split " " $match)
                echo "Alias tip: $alias[2]"
                break
            end
        end
    end
end

function print_aliases --on-event fish_preexec
    set subcommands (string replace -ar '[()|]' '\0' $argv | string split0)

    for subcommand in $subcommands
        set subcommand (string replace -ar "(^\s*|\s*\$)" "" $subcommand)

        if test "$subcommand" = ''
            continue
        end

        set params (string split ' ' $subcommand)

        if test "$params[1]" = 'g'
            set params git $params[2..-1]
        end

        for i in (seq (count $params) 1)
            if test -z "$params[$i]"
                continue # sometimes we get empty strings
            end

            set escaped_params (string escape --style=regex "$params[1..$i]")
            set match (alias | grep "^alias \w+ '$escaped_params'\$")
            if test -n "$match"
                set alias (string split " " $match)
                echo "Alias tip: $alias[2]"
                break
            end
        end
    end
end

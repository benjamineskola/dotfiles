function mdless --wraps mdless
    if test $COLUMNS -gt 80
        set -p argv --width (math "round($COLUMNS * 2/3)")
    end
    command mdless $argv
end

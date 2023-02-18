function mdwc
    set total 0
    for file in $argv
        set tmpfile (mktemp).md
        trap "rm -f '$tmpfile'" EXIT INT

        perl -0777 -pe 's/^---+\n(\n|.)*?\n---+\n+//' "$file" >"$tmpfile"

        set count (pandoc -L ~/Code/lua-filters/wordcount/wordcount.lua "$tmpfile" | grep words | cut -d ' ' -f 1)
        set total (math $count + $total)
        printf "%8d %s\n" $count $file

        rm -f "$tmpfile"
    end
    printf "%8d total\n" $total
end

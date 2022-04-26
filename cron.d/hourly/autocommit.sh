#!/bin/sh
set -e

/usr/local/bin/fdautil exec ~/bin/bearsync

for dir in $(fd -0 -HI '^\.git$' ~/Documents | xargs -0 dirname); do
    cd "$dir" || continue
    git ls-files -moz '*.md' | /usr/local/bin/fdautil exec /usr/bin/xargs -0 -I{} /opt/homebrew/bin/fish -lc 'mdlint -w "{}"'

    if [ "$(basename "$dir")" = Notes ]; then
        git ls-files -moz | xargs -0 perl -0777 -i -pe 's/\n+#/\n\n#/g;s/(^|\n)(#+ .+)\n+/\n$1$2\n/g'
        git ls-files -moz | xargs -0 sed -i '' '1{/^$/d;}'
        git ls-files -moz | xargs -0 perl -0777 -i -pe 's/\n\n\n/\n\n/g'
        git ls-files -moz | xargs -0 -n 1 perl -0777 -i -pe 's/(\n#+ .*)\n\n+/\1\n/g'
    fi

    /usr/local/bin/fdautil exec ~/bin/autocommit.sh "$dir"
done

/usr/local/bin/fdautil exec ~/bin/bearsync

#!/bin/sh
set -e

fd -0 -HI '^\.git$' ~/Documents | xargs -0 dirname | while read -r dir; do
    cd "$dir" || continue
    git ls-files -moz '*.md' | /usr/local/bin/fdautil exec /usr/bin/xargs -0 -I{} /opt/homebrew/bin/fish -lc 'mdlint -w "{}"'
    /usr/local/bin/fdautil exec ~/bin/autocommit.sh "$dir"
done

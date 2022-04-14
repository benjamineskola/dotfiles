#!/bin/sh
set -e

~/bin/bearsync

for dir in $(fd -0 -HI '^\.git$' ~/Documents | xargs -0 dirname); do
    cd "$dir" || continue
    git ls-files -m -z '*.md' | xargs -0 -I{} fish -lc 'mdlint -w "{}"'

    ~/bin/autocommit.sh "$dir"
done

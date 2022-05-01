#!/bin/sh
set -e

fd -0 -HI '^\.git$' ~/Documents | xargs -0 dirname | while read -r dir; do
    cd "$dir" || continue
    git ls-files --exclude-standard -moz '*.md' | xargs -0 -I{} fish -lc 'mdlint -w "{}"'

    ~/bin/autocommit.sh "$dir"
done

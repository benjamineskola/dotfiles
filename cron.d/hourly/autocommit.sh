#!/bin/sh
set -e

fd -HI '^\.git$' ~/Documents -E 'Notes/' -X dirname | while read -r dir; do
	cd "$dir" || continue
	git ls-files --exclude-standard -moz '*.md' | xargs -0 prettier -w

	~/bin/autocommit.sh "$dir"
done

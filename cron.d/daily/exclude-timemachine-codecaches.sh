#!/bin/sh
set -e

fd -HI -t d --prune '^(node_modules|dist-newstyle|\.stack-work|target|\.(mypy|pytest|sass)_cache)$' ~ -x tmutil addexclusion
defaults read /Library/Preferences/com.apple.TimeMachine SkipPaths | sed -E 's/(^ *"|",?$)//g; s,^~ben,/Users/ben,' | grep '^/' | while read -r dir; do
    test -d "$dir" || tmutil removeexclusion "$dir" 2>/dev/null || true
done

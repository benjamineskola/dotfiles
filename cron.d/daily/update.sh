#!/bin/sh
set -e

for dir in ~/bin ~/.config; do
    cd "$dir" || continue
    git pull --rebase -q || true

    cd
done

brew bundle install | grep -v '^Using'

for req in ~/Code/*/requirements*.txt; do
    proj="$(dirname "$req")"
    test -f "$proj/.venv" || pip install -r "$req"
done

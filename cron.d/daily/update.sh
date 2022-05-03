#!/bin/sh
set -e

for dir in ~/bin ~/.config; do
    cd "$dir" || continue
    git pull --rebase -q || true

    cd
done

brew bundle --global install | grep -v '^Using'

for lang in python ruby; do
    asdf plugin-update "$lang"
    version=$(asdf latest "$lang")
    asdf install "$lang" "$version" && asdf global "$lang" "$version" && asdf reshim "$lang"
done

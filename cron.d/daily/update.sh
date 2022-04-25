#!/bin/sh
set -e

for dir in ~/bin ~/.config; do
    cd $dir || continue
    git pull --rebase

    cd
done

brew bundle --global install | grep -v '^Using'

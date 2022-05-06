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

for lang in $(asdf plugin list); do
    if [ "$lang" = ruby ] && hostname | grep -qi '^gds'; then
        continue # cf. govuk-update.sh
    fi

    if [ "$(asdf list "$lang" | wc -l)" -eq 1 ]; then
        # Ignore those with only one version even if it's not the latest
        continue
    fi

    latest=$(asdf latest "$lang")
    for version in $(asdf list "$lang"); do
        if [ "$version" != "$latest" ]; then
            asdf uninstall "$lang" "$version"
        fi
    done
done

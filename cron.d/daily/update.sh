#!/bin/sh
set -e

for dir in ~/bin ~/.config; do
    cd "$dir" || continue
    git pull --rebase -q || true

    cd
done

brew bundle --global install | grep -v '^Using'

for lang in $(asdf plugin list); do
    asdf plugin-update "$lang"

    if [ "$lang" = haskell ]; then
        version=$(curl https://www.stackage.org | htmlq -t li a | grep -E "LTS [0-9.]+" | sort -Vr | head -n 1 | grep -E -o "ghc-[0-9.]+" | cut -d - -f 2)
    else
        version=$(asdf latest "$lang")
    fi

    asdf install "$lang" "$version" && asdf global "$lang" "$version" && asdf reshim "$lang"
    ln -sf "$(asdf where "$lang")" "$ASDF_DATA_DIR/installs/$lang/default"

    if [ "$lang" = ruby ] && hostname | grep -qi '^gds'; then
        continue # cf. govuk-update.sh
    fi

    if [ "$(asdf list "$lang" | wc -l)" -eq 1 ]; then
        # Ignore those with only one version even if it's not the latest
        continue
    fi

    for installed_version in $(asdf list "$lang" | grep -v default); do
        if [ "$installed_version" != "$version" ] && [ "$installed_version" != nightly ]; then
            asdf uninstall "$lang" "$installed_version"
        fi
    done
done
(
    cd ~/.config
    git commit -m "Update versions in asdf" tool-versions
)

for version in $(asdf list rust | grep -v nightly); do
    ln -sf "$(asdf where rust nightly)"/toolchains/nightly-* "$(asdf where rust "$version")"/toolchains/
done

for req in ~/Code/*/requirements*.txt; do
    proj="$(dirname "$req")"
    test -f "$proj/.venv" || pip install -r "$req"
done

#!/bin/sh
set -e

hostname | grep -qi '^gds' || exit

versions=$(for dir in ~/govuk/*/; do
    cd "$dir" || continue
    test -f ".ruby-version" || continue

    repo=$(git remote get-url origin | cut -d ':' -f 2 | sed 's/\.git$//')
    curl -gkLsf "https://raw.githubusercontent.com/$repo/main/.ruby-version" || true
done | sort -u | grep -v '^1\.')

echo "$versions" | xargs -n 1 asdf install ruby

latest_ruby=$(asdf latest ruby)
versions="$versions
$latest_ruby"

for dir in "$ASDF_DATA_DIR"/installs/ruby/*; do
    version=$(basename "$dir")
    echo "$versions" | grep -q "^$version$" || asdf uninstall ruby "$version"
done

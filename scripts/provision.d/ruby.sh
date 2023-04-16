#!/bin/sh
set -e

log "Ensure .gem points to the right place"
ln_relative "$XDG_DATA_HOME/gem" ~/.gem

RUBIES_DIR=${RUBIES_DIR:-$XDG_DATA_HOME/rubies}

log "Fetch list of current stable versions"
CURRENT_VERSIONS="$(curl -sS https://raw.githubusercontent.com/postmodern/ruby-versions/master/ruby/stable.txt | grep -v '^2\.6\.')"

log "Install all current stable versions"
for version in $CURRENT_VERSIONS; do
    if brew --prefix capstone 2>/dev/null; then
        CXXFLAGS="-I$(brew --prefix capstone)/include"
        LDFLAGS="-L$(brew --prefix capstone)/lib"
        export CXXFLAGS LDFLAGS
    fi
    RUBY_TMP="$(mktemp -d)"
    ruby-install --no-install-deps --no-reinstall --cleanup -r "$RUBIES_DIR" -s "$RUBY_TMP" "$version"
done

log "Set default ruby version to the latest"
DEFAULT_VERSION="$(echo "${CURRENT_VERSIONS}" | tail -n 1)"
ln_relative "$RUBIES_DIR/ruby-$DEFAULT_VERSION" "$RUBIES_DIR/default"

log "Install default gems for all installed rubies"
for installation in "$RUBIES_DIR"/ruby-*; do
    (
        cp "$XDG_CONFIG_HOME/Gemfile" "$installation"
        version=$(basename "$installation" | cut -d '-' -f 2)
        chruby-exec "$version" -- bundle install --gemfile "$installation/Gemfile"
        rm -f "$installation/Gemfile" "$installation/Gemfile.lock"
    ) &
done
wait

#!/usr/bin/env zsh
set -e

test "$(uname -s)" = Darwin || exit 1
test -e /tmp/install.lock && exit
touch /tmp/install.lock

TRAPEXIT() {
	rm -f /tmp/install.lock
}

brew update > /dev/null
brew upgrade

wanted=$(cat $XDG_CONFIG_HOME/packages)
installed=$(brew list -1)

to_install=$(comm -23 <(echo "$wanted") <(echo "$installed"))

for package in $to_install; do
	brew install $package || true  # don't bail if a single package fails
done

rbenv versions | grep -q 1.9.3-p194 || rbenv install 1.9.3-p194

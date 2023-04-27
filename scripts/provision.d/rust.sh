#!/bin/sh
set -e

if ! [ -e "$CARGO_HOME/bin/rustup" ]; then
	log "Initialise rustup"
	rustup-init --no-update-default-toolchain --no-modify-path -y
fi

log "Set default rust version to stable"
"$CARGO_HOME/bin/rustup" default stable

log "Additionally install nightly"
"$CARGO_HOME/bin/rustup" install nightly

log "Use nightly for specific components"
# shellcheck disable=SC2043
for item in rustfmt; do
	"$CARGO_HOME/bin/rustup" component add "$item" --toolchain nightly
done

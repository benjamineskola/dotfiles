#!/bin/sh
set -e

log "Get available stable versions"
log "Install stable versions"
for major_version in $(fnm ls-remote | cut -d '.' -f 1 | sort -uV | sed -E -n '/14/,${/[24680]/p;}'); do
	version=$(fnm ls-remote | grep "^$major_version\." | tail -n 1 | cut -d ' ' -f 1)
	fnm install "$version"
done

log "Set newest version as default"
fnm default "$version"

log "Install default packages"
xargs yarn global add <"$XDG_CONFIG_HOME/default-node-packages.txt"

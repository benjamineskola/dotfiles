#!/bin/sh
set -e

cd ${XDG_CONFIG_HOME:-$HOME/.config}
for i in ./scripts/install-*.sh; do
  sh "$i"
done

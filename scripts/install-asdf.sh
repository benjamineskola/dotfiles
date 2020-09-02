#!/bin/sh
set -e

if command -v asdf; then
  while read -r lang ver; do
    if ! asdf plugin-list | grep -q "$lang"; then
      asdf plugin add "$lang"

      if [ "$lang" = nodejs ]; then
        bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
      fi
    fi

    if ! asdf list "$lang" | grep -q "^ *$ver$"; then
      asdf install "$lang" "$ver"
    fi
  done <tool-versions
fi

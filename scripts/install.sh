#!/bin/sh
set -e

if command -v asdf; then
  while read lang ver; do
    if ! asdf plugin-list | grep -q "$lang"; then
      asdf plugin add "$lang"

      if [ "$lang" = nodejs ]; then
        bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
      fi
    fi

    if ! asdf list $lang | grep -q "^ *$ver$"; then
      asdf install "$lang" "$ver"
    fi
  done <tool-versions
fi

command -v brew && brew bundle --global install | grep -v '^Using'

command -v pip3 && test -x "$(command -v python3)" && pip3 install --upgrade pip && pip3 install -r requirements.txt | grep -v '^Requirement already satisfied'

command -v npm && xargs npm install --silent -g <npm-globals.txt

command -v go && xargs go get -u <go-globals.txt

asdf reshim

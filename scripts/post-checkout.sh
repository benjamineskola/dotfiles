#!/bin/sh
set -ex
echo in post checkout

if [ "$3" = 0 ]; then
  # file checkout
  exit
fi

changed_files=$(git diff-tree -r --name-only --no-commit-id "$1" "$2")

check_run() {
  echo "$changed_files" | grep --quiet "$1" && eval "$2" || true
}

check_run tool-versions ./scripts/install.sh

check_run Brewfile ./scripts/install-brew.sh
check_run Gemfile ./scripts/install-gem.sh
check_run go-globals.txt ./scripts/install-go.sh
check_run npm-globals.txt ./scripts/install-npm.sh
check_run requirements.txt ./scripts/install-pip.sh
check_run LaunchAgents ./scripts/install-zzlaunchagents.sh

#!/bin/sh
set -ex
echo in post checkout

if [ "$3" = 0 ]; then
  # file checkout
  exit
fi

changed_files=$(git diff-tree -r --name-only --no-commit-id "$1" "$2")

has_changed() {
  echo "$changed_files" | grep -E --quiet "$1"
}

check_run() {
  if has_changed "$1"; then
    eval "$2"
  fi
}

if has_changed '(tool-versions|scripts/)'; then
  ./scripts/install.sh
else
  check_run '(^|/)_.*' ./scripts/install-dotfiles.sh

  check_run Brewfile ./scripts/install-brew.sh
  check_run Gemfile ./scripts/install-gem.sh
  check_run go-globals.txt ./scripts/install-go.sh
  check_run npm-globals.txt ./scripts/install-npm.sh
  check_run '(requirements.txt|pip/pip.conf)' ./scripts/install-pip.sh
  check_run nvim/plugins.vim ./scripts/install-vim.sh
  check_run LaunchAgents ./scripts/install-zzlaunchagents.sh

  ./scripts/install-bat.sh
  ./scripts/install-iterm.sh
fi

#!/bin/sh
set -e

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
        echo "running $2" | ts
        eval "$2"
    fi
}

if has_changed '(tool-versions|scripts/)'; then
    ./scripts/install.sh
else
    check_run '(^|/)_.*' ./scripts/install-dotfiles.sh

    check_run nvim/plugins.vim ./scripts/install-vim.sh
    check_run LaunchAgents ./scripts/install-zzlaunchagents.sh

    echo "running ./scripts/install-bat.sh" | ts
    ./scripts/install-bat.sh
    echo "running ./scripts/install-iterm.sh" | ts
    ./scripts/install-iterm.sh
fi

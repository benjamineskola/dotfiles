#!/bin/sh
set -e

log "Ensure default XDG paths are symlinked"
mkdir -p "$HOME/.local"
if ! [ "$XDG_DATA_HOME" = "$HOME/.local/share" ]; then
    ln_relative "$XDG_DATA_HOME" "$HOME/.local/share"
fi
if ! [ "$XDG_STATE_HOME" = "$HOME/.local/state" ]; then
    ln_relative "$XDG_STATE_HOME" "$HOME/.local/state"
fi

log "Ensure dotfiles and scripts are up to date"
for repo in "$XDG_CONFIG_HOME" "$HOME/bin" "$HOME/bin"/*/; do
    cd "$repo" || continue
    test -d .git || continue
    git pull || true
done

log "Install dotfiles"
for file in "$XDG_CONFIG_HOME"/_* "$XDG_CONFIG_HOME"/private/_*; do
    ln_relative "$file" "$HOME/$(basename "$file" | tr _ .)"
done

log "Clean up old dotfile links"
find -L "$HOME" -type l -maxdepth 1 -name '.*' -exec rm {} +

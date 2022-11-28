#!/bin/sh
set -e

if [ "$3" = 0 ] || [ "$PRE_COMMIT_CHECKOUT_TYPE" = 0 ]; then
    # file checkout
    exit
fi

if [ -e .git/rebase-merge ] || [ -e .git/rebase-apply ]; then
    exit
fi

for i in _* private/_*; do
    test -e "$i" &&
        ln -sfh ".config/$i" "$HOME/.$(basename "$i" | sed 's/^_//')"
done
find -L "$HOME" -type l -maxdepth 1 -name '.*' -exec rm {} +

if command -v nvim; then
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'lua require("config.plugins")' -c 'PackerSync'
fi

if [ "$(uname -s)" = Darwin ]; then
    if [ -z "$(find "$HOME/.config/fish/conf.d" -maxdepth 1 -name zzz_iterm2_shell_integration.fish -mtime -1)" ]; then
        curl https://iterm2.com/shell_integration/fish >"$HOME/.config/fish/conf.d/zzz_iterm2_shell_integration.fish"
    fi

    ln -sf ~/.config/scripts/iterm* ~/Library/Application\ Support/iTerm2/Scripts/

    curl -O https://gist.githubusercontent.com/nicm/ea9cf3c93f22e0246ec858122d9abea1/raw/37ae29fc86e88b48dbc8a674478ad3e7a009f357/tmux-256color
    tic -x tmux-256color
    rm -f tmux-256color

    test -d LaunchAgents && mkdir -p ~/Library/LaunchAgents
    for i in LaunchAgents/*.plist; do
        launchctl unload "$HOME/Library/LaunchAgents/$(basename "$i")"
        sed -E "s,\\\$PATH,$PATH,g;  s,\\\$HOMEBREW_PREFIX,$HOMEBREW_PREFIX,g; s,\\\$HOME,$HOME,g; s,\\\$XDG_CONFIG_HOME,$XDG_CONFIG_HOME,g; s,\\\$XDG_DATA_HOME,$XDG_DATA_HOME,g; s,\\\$XDG_CACHE_HOME,$XDG_CACHE_HOME,g" "$HOME/.config/$i" >"$HOME/Library/LaunchAgents/$(basename "$i")"
        launchctl load "$HOME/Library/LaunchAgents/$(basename "$i")"
    done

    for i in "$HOME"/Library/LaunchAgents/uk.eskola.*.plist; do
        if ! [ -f "$HOME/.config/LaunchAgents/$(basename "$i")" ]; then
            launchctl unload "$i"
            rm "$i"
        fi
    done

    login.d/macos.sh
fi

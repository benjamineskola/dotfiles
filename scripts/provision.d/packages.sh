#!/bin/sh
set -e
go install github.com/nametake/golangci-lint-langserver@latest

if [ -z "$(find "$HOME/.config/bat/themes" -maxdepth 1 -iname 'catppucin*' -mtime -1)" ]; then
	(
		cd "$HOME/.config/bat/themes"
		curl -O https://raw.githubusercontent.com/catppuccin/bat/main/Catppuccin-mocha.tmTheme
		bat cache --build
	)
fi

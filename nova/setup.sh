#!/bin/sh
set -e
defaults write com.panic.Nova EditorDarkTheme "Monokai Pro (Spectrum)"
defaults write com.panic.Nova EditorLightTheme "Monokai Pro (Spectrum)"
defaults write com.panic.Nova EnsureTrailingNewline 1
defaults write com.panic.Nova FontName "JetBrains Mono NL"
defaults write com.panic.Nova FontSize 14
defaults write com.panic.Nova TerminalDarkTheme "Monokai Pro (Spectrum)"
defaults write com.panic.Nova TerminalLightTheme "Monokai Pro (Spectrum)"
defaults write com.panic.Nova TrimTrailingWhitespace 1

defaults write com.panic.Nova CustomSyntaxModes -array-add '{Extension="_Brewfile"; Syntax=ruby;}'
defaults write com.panic.Nova CustomSyntaxModes -array-add '{Extension="flake8"; Syntax=ini;}'

ln -sf ../../../.config/nova/UserConfiguration.json ~/Library/Application\ Support/Nova/UserConfiguration.json

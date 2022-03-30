#!/bin/sh
set -e
defaults write com.panic.Nova EditorDarkTheme gruvbox
defaults write com.panic.Nova EditorLightTheme "Pure Solarized Light"
defaults write com.panic.Nova EnsureTrailingNewline 1
defaults write com.panic.Nova FontName "FiraCodeNerdFontCompleteM-Regular"
defaults write com.panic.Nova FontSize 14
defaults write com.panic.Nova TerminalDarkTheme gruvbox
defaults write com.panic.Nova TerminalLightTheme "Pure Solarized Light"
defaults write com.panic.Nova TrimTrailingWhitespace 1

defaults write com.panic.Nova CustomSyntaxModes -array-add '{Extension="_Brewfile"; Syntax=ruby;}'
#!/bin/sh

# Make iterm config behave
defaults write com.googlecode.iterm2 DynamicProfilesPath "$XDG_CONFIG_HOME/iterm2";
defaults write com.googlecode.iterm2 PreferredBaseDir "$XDG_CACHE_HOME/iTerm2";

# Don't automatically rearrange spaces
defaults write com.apple.dock mru-spaces -bool false

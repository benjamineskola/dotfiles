#!/bin/sh
for i in _* private/_*; do
  test -e "$i" &&
    ln -sfh .config/$i $HOME/.$(basename $i | sed 's/^_//')
done

if [ "$(uname -s)" = Darwin ]; then
  test -d LaunchAgents && mkdir -p ~/Library/LaunchAgents
  for i in LaunchAgents/*.yml; do
    scripts/yaml2plist.rb $i >$HOME/Library/LaunchAgents/$(basename $i .yml).plist
  done
  for i in LaunchAgents/*.plist; do
    test -e "$i" &&
      ln -f $HOME/.config/$i $HOME/Library/LaunchAgents
  done

  ln -sfhF ../../../.config/iterm2 "$HOME/Library/Application Support/iTerm2/DynamicProfiles"
fi

test -n "$(find $HOME/.config/fish/conf.d -maxdepth 1 -name 01_iterm2_shell_integration.fish -mtime +1)" &&
  curl https://iterm2.com/shell_integration/fish >$HOME/.config/fish/conf.d/01_iterm2_shell_integration.fish

command -v brew && brew bundle --global install

command -v bat && bat cache --build
command -v pip3 && pip3 install -r requirements.txt
command -v yarn && xargs yarn global add <npm-globals.txt

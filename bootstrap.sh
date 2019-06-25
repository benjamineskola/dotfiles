#!/bin/sh
for i in _* private/_*; do
  ln -sfh .config/$i $HOME/.$(basename $i | sed 's/^_//')
done

test -d LaunchAgents && mkdir -p ~/Library/LaunchAgents
for i in LaunchAgents/*.yml; do
  scripts/yaml2plist.rb $i >$HOME/Library/LaunchAgents/$(basename $i .yml).plist
done
for i in LaunchAgents/*.plist; do
  ln -f $HOME/.config/$i $HOME/Library/LaunchAgents
done

mkdir -p ~/Code
for i in Code/*; do
  ln -sfh ../.config/$i $HOME/Code
done

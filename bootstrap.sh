#!/bin/sh
for i in _* private/_*; do
  ln -sfh .config/$i $HOME/.$(basename $i | sed 's/^_//')
done

test -d LaunchAgents && mkdir -p ~/Library/LaunchAgents
for i in LaunchAgents/*; do
  ln -f $HOME/.config/$i $HOME/Library/LaunchAgents
done

mkdir -p ~/Code
for i in Code/*; do
  ln -sfh ../.config/$i $HOME/Code
done

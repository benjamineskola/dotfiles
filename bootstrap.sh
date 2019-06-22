#!/bin/sh
for i in _* private/_*; do
  ln -sf .config/$i $HOME/.$(basename $i | sed 's/^_//')
done

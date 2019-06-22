#!/bin/sh
for i in _* private/_*; do
  ln -sf $i $HOME/.${i#_}
done

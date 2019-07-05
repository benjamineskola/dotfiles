#!/bin/sh
set -e

echo "export XDG_CONFIG_HOME='$HOME/.config';"
if [ "$(uname -s)" = Darwin ]; then
  echo "export XDG_DATA_HOME='$HOME/Library';"
  echo "export XDG_CACHE_HOME='$HOME/Library/Caches';"
else
  echo "export XDG_DATA_HOME='$HOME/.data';"
  echo "export XDG_CACHE_HOME='$HOME/.cache';"
fi

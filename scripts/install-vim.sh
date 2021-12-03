#!/bin/sh
set -e

if command -v nvim; then
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
fi

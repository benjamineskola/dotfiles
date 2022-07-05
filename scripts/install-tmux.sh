#!/bin/sh
set -e

curl -O https://gist.githubusercontent.com/nicm/ea9cf3c93f22e0246ec858122d9abea1/raw/37ae29fc86e88b48dbc8a674478ad3e7a009f357/tmux-256color
tic -x tmux-256color
rm -f tmux-256color

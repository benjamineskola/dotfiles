#!/bin/sh
set -e

fd -HI -t d --prune '^(node_modules|dist-newstyle|\.stack-work|target|\.(mypy|pytest|sass)_cache)$' ~ -x tmutil addexclusion

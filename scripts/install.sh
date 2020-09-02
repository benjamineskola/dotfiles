#!/bin/sh
set -e

for i in ./scripts/install-*.sh; do
  sh "$i"
done

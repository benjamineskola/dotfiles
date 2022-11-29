#!/bin/sh
set -e

for req in ~/Code/*/requirements*.txt; do
    proj="$(dirname "$req")"
    test -f "$proj/.venv" || pip install -r "$req"
done

#!/bin/bash
set -eo pipefail

for i in "$1"/*; do
    echo "$i"
    "$i" || true
done \
    1> >(ts >&1) \
    2> >(ts >&2)

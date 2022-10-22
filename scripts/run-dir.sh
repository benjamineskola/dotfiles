#!/bin/bash
set -eo pipefail

for dir in "$@"; do
    test -d "$dir" || continue

    for i in "$dir"/*; do
        test -e "$i" || continue
        echo "$i"
        "$i" || true
    done \
        1> >(ts >&1) \
        2> >(ts >&2)
done

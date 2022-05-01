#!/bin/bash
set -eo pipefail

# shellcheck disable=SC1091
. "$(brew --prefix asdf)/libexec/asdf.sh"

for i in "$1"/*; do
    echo "$i"
    "$i"
done \
    1> >(ts >&1) \
    2> >(ts >&2)

#!/bin/sh
set -e
# set -o pipefail

VERBOSE=0

case "$1" in
-v | --verbose)
    VERBOSE=1
    ;;
-d | --debug)
    VERBOSE=2
    ;;
esac

if [ "$VERBOSE" -gt 0 ]; then
    log() {
        printf "==> %s [%s]\n" "$SCRIPT_NAME" "$@" >&2
    }
else
    log() { :; }
fi

if [ "$VERBOSE" -gt 1 ]; then
    set -x
fi

for script in "$XDG_CONFIG_HOME"/scripts/provision.d/*.sh; do
    SCRIPT_NAME=$(basename "$script" .sh)
    export SCRIPT_NAME

    case "$SCRIPT_NAME" in
    os-"$(uname -s | tr "[:upper:]" "[:lower:]")")
        SCRIPT_NAME=$(uname -s | tr "[:upper:]" "[:lower:]")
        ;;
    os-*) continue ;;
    esac

    start=$(date +%s)
    if [ "$VERBOSE" -gt 1 ]; then
        # shellcheck source=/dev/null
        . "$script"
    else
        # shellcheck source=/dev/null
        . "$script" >/dev/null
    fi
    end=$(date +%s)

    if [ "$VERBOSE" -gt 0 ]; then
        log "done in $((end - start)) seconds"
    fi
done

#!/bin/sh
set -e
# set -o pipefail

VERBOSE=0

while getopts vdo: arg; do
    case $arg in
    v) VERBOSE=$((VERBOSE + 1)) ;;
    d) VERBOSE=$((VERBOSE + 2)) ;;
    o) ONLY="$OPTARG" ;;
    *)
        exit 1
        ;;
    esac
done
shift $((OPTIND - 1))

if [ "$VERBOSE" -gt 0 ]; then
    log() {
        printf "==> %s [%s]\n" "$SCRIPT_NAME" "$@" >&2
    }
    if [ "$VERBOSE" -gt 1 ]; then set -x; fi
else
    log() { :; }
fi

relpath() {
    pos="${1%%/}"
    ref="${2%%/}"
    down=''

    while :; do
        test "$pos" = '/' && break
        case "$ref" in $pos/*) break ;; esac
        down="../$down"
        pos=${pos%/*}
    done

    echo "$down${ref##"$pos/"}"
}

ln_relative() {
    ln -sfh "$(relpath "$(dirname "$2")" "$(realpath "$1")")" "$2"
}

for script in "$XDG_CONFIG_HOME"/scripts/provision.d/*.sh; do
    SCRIPT_NAME=$(basename "$script" .sh)
    export SCRIPT_NAME

    if [ -n "$ONLY" ] && [ "$ONLY" != "$SCRIPT_NAME" ]; then
        continue
    fi

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

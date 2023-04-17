#!/bin/sh
set -e
# set -o pipefail

VERBOSE=0

while getopts vdo: arg; do
    case $arg in
    v) VERBOSE=$((VERBOSE + 1)) ;;
    d) VERBOSE=$((VERBOSE + 3)) ;;
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
    if [ "$VERBOSE" -gt 2 ]; then set -x; fi
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

run_script() {
    SCRIPT_PATH=$1
    SCRIPT_NAME=$(basename "$SCRIPT_PATH" .sh)

    case "$SCRIPT_NAME" in
    os-"$(uname -s | tr "[:upper:]" "[:lower:]")")
        SCRIPT_NAME=${SCRIPT_NAME#os-}
        ;;
    os-*) return ;;
    esac

    start=$(date +%s)
    if [ "$VERBOSE" -gt 1 ]; then
        # shellcheck source=/dev/null
        . "$SCRIPT_PATH"
    else
        # shellcheck source=/dev/null
        . "$SCRIPT_PATH" >/dev/null
    fi
    end=$(date +%s)

    if [ "$VERBOSE" -gt 0 ]; then
        log "done in $((end - start)) seconds"
    fi
}

if [ -n "$ONLY" ]; then
    run_script "$XDG_CONFIG_HOME/scripts/provision.d/$ONLY.sh"
else
    for script in "$XDG_CONFIG_HOME"/scripts/provision.d/*.sh; do
        run_script "$script"
    done
fi

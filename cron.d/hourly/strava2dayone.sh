#!/bin/sh
set -e

cd ~/Code/strava-reporter || exit 1
pgrep -lf /dayone.py && exit 1

# shellcheck disable=SC1091
. /Users/ben/Library/virtualenvs/strava-reporter/bin/activate
./dayone.py run
./dayone.py ride
./dayone.py walk

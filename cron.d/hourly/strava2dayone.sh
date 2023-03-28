#!/bin/sh
set -e

cd ~/Code/strava-reporter || exit 1
pgrep -lf /dayone.py && exit 1

PYTHON=python
if [ -d ./.venv ]; then
    PYTHON=$PWD/.venv/bin/python
fi

$PYTHON ./dayone.py run
$PYTHON ./dayone.py ride
$PYTHON ./dayone.py walk

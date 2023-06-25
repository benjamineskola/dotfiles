#!/bin/sh
set -e

cd ~/Code/strava-reporter || exit 1
pkill -f dayone.py || true

PYTHON=python
if [ -d ./.venv ]; then
	PYTHON=$PWD/.venv/bin/python
fi

$PYTHON ./dayone.py run &
$PYTHON ./dayone.py ride &
$PYTHON ./dayone.py walk &

for _ in $(seq 30); do
	pgrep -lf dayone.py || exit
	sleep 10
done

pkill -f dayone.py

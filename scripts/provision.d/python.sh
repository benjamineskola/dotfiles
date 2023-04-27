#!/bin/sh
set -e

log "Get available minor versions"
MINOR_VERSIONS="$(python-build --definitions | grep "^3" | grep -v "[a-z]" | cut -d . -f 1-2 | sort -u --version-sort | tail -n +8)"

log "Install latest patch version for each minor version"
for version in $MINOR_VERSIONS; do
	patch_version=$(python-build --definitions | grep "^$version\." | tail -n 1)
	PYTHON="$PYENV_ROOT/versions/$patch_version/bin/python"

	if [ -f "$PYTHON" ]; then
		continue
	fi

	pyenv install -s "$patch_version"
done

log "Set newest version as default"
pyenv global "$patch_version"

log "Upgrade pip"
for PYTHON in "$PYENV_ROOT/versions"/*/bin/python; do
	$PYTHON -m pip install --upgrade pip &
done
wait

log "Install global requirements"
for PYTHON in "$PYENV_ROOT/versions"/*/bin/python; do
	$PYTHON -m pip install -r "$XDG_CONFIG_HOME/requirements.txt" &
done
wait

#!/bin/sh
set -e

log "Don't automatically rearrange spaces"
defaults write com.apple.dock mru-spaces -bool false

log "Update Homebrew and install required packages"
if [ -O /opt/homebrew ] && [ -z "$(find /opt/homebrew -type f -mtime -1 | head -n 1)" ]; then
	brew update
	brew upgrade
	brew bundle --global install
	brew bundle --global cleanup
fi

log "Link preferences into place"
# shellcheck disable=SC2043
for pref in espanso; do
	ln_relative "$XDG_CONFIG_HOME/$pref" "$HOME/Library/Preferences/$pref"
done
log "Link application support into place"
# shellcheck disable=SC2043
for pref in rustfmt; do
	ln_relative "$XDG_CONFIG_HOME/$pref" "$HOME/Library/Application Support/$pref"
done

log "Install Hammerspoon spoons"
if [ -d "$XDG_CONFIG_HOME/_hammerspoon/Spoons/vendor" ]; then
	(
		cd "$XDG_CONFIG_HOME/_hammerspoon/Spoons/vendor"
		git pull --depth 1
	)
else
	git clone --depth 1 https://github.com/Hammerspoon/Spoons.git "$XDG_CONFIG_HOME/_hammerspoon/Spoons/vendor"
fi
if [ -d "$XDG_CONFIG_HOME/_hammerspoon/Spoons/Bear.spoon" ]; then
	(
		cd "$XDG_CONFIG_HOME/_hammerspoon/Spoons/Bear.spoon"
		git pull --depth 1
	)
else
	git clone --depth 1 https://github.com/dcreemer/hammerspoon-bear.git "$XDG_CONFIG_HOME/_hammerspoon/Spoons/Bear.spoon"
fi

log "Ensure LaunchAgents directory exists"
AGENT_DIR="$HOME/Library/LaunchAgents"
mkdir -p "$AGENT_DIR"

if [ "$(hostname -s)" = MacBook-Pro ]; then
	log "Install setenv.plist"
	if ! cmp -s "$XDG_CONFIG_HOME/setenv.plist" "$AGENT_DIR/uk.eskola.setenv.plist"; then
		launchctl unload uk.eskola.setenv.plist
		cp "$XDG_CONFIG_HOME/setenv.plist" "$AGENT_DIR/uk.eskola.setenv.plist"
		launchctl load uk.eskola.setenv.plist
	fi

	log "Generate cronjobs"
	template="$XDG_CONFIG_HOME/cron.d/LaunchAgent.tmpl"
	for JOB_PATH in "$XDG_CONFIG_HOME"/cron.d/*/* "$XDG_CONFIG_HOME"/private/cron.d/*/*; do
		JOB_NAME="$(basename "$JOB_PATH" | rev | cut -d . -f 2- | rev)"

		schedule_type="$(basename "$(dirname "$JOB_PATH")")"

		JOB_SCHEDULE="<key>Minute</key><integer>0</integer>"
		JOB_NAME="uk.eskola.cron$schedule_type.$JOB_NAME"

		if [ "$schedule_type" = daily ]; then
			JOB_SCHEDULE="$JOB_SCHEDULE<key>Hour</key><integer>7</integer>"
		fi

		TMP_PATH="$TMPDIR/$JOB_NAME.plist"
		INSTALL_PATH="$AGENT_DIR/$JOB_NAME.plist"

		export JOB_NAME JOB_PATH JOB_SCHEDULE
		envsubst <"$template" >"$TMP_PATH"

		if [ -e "$INSTALL_PATH" ]; then
			if ! cmp -s "$TMP_PATH" "$INSTALL_PATH"; then
				launchctl unload "$JOB_NAME.plist"
				cp -f "$TMP_PATH" "$INSTALL_PATH"
				launchctl load "$JOB_NAME.plist"
			fi
			rm -f "$TMP_PATH"
		fi
	done

	log "Configure logrotate"
	mkdir -p /opt/homebrew/etc/logrotate.d
	cat >/opt/homebrew/etc/logrotate.d/cron.conf <<EOF
$HOME/Library/Logs/uk.eskola.* {
    daily
    copytruncate
    rotate 3
    size 1M
    compress
}
EOF
fi

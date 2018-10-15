setopt extendedglob

_load_settings() {
	dir=$1; shift
	if [[ -d "${dir}" ]]; then
		for config in "$dir"/*.zsh(N-.); do
			source ${config}
		done
	fi
}

_load_settings ~/.zsh/env
_load_settings ~/.zsh/env/$(uname)
_load_settings ~/.zsh/env/$(hostname -s)

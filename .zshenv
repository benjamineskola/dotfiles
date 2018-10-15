setopt extendedglob
FQDN=$(hostname -f || hostname)
HOSTNAME=${FQDN%%.*}
DOMAIN=${FQDN#*.}
export HOSTNAME DOMAIN FQDN

export OS=${OSTYPE%%[0-9.]*}

_load_settings() {
	dir=$1; shift
	if [[ -d "${dir}" ]]; then
		for config in "$dir"/*.zsh(N-.); do
			source ${config}
		done
	fi
}

_load_settings ~/.zsh/env
_load_settings ~/.zsh/env/${OS}
_load_settings ~/.zsh/env/${HOSTNAME}

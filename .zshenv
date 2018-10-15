setopt extendedglob
FQDN=$(hostname -f || hostname)
HOSTNAME=${FQDN%%.*}
DOMAIN=${FQDN#*.}
export HOSTNAME DOMAIN FQDN

export OS=${OSTYPE%%[0-9.]*}

_load_settings() {
	base_dir=$1; shift

	for dir in ${base_dir}/pre ${base_dir} ${base_dir}/post; do
		if [[ -d "${dir}" ]]; then
			for config in "$dir"/*.zsh(N-.); do
				source ${config}
			done
		fi
	done
}

_load_settings ~/.zsh/env
_load_settings ~/.zsh/env/${OS}
_load_settings ~/.zsh/env/${HOSTNAME}

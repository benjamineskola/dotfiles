function vi --wraps nvim
    for file in $argv
        set -gx GIT_ROOT (pushd (dirname "$file"); git rev-parse --show-toplevel 2>/dev/null; popd)

        if [ -n "$GIT_ROOT" ]
            set -gx NVIM_LISTEN_ADDRESS /tmp/nvimsocket-(echo "$GIT_ROOT" | sha256sum | cut -d ' ' -f 1)
        else
            set -gx NVIM_LISTEN_ADDRESS /tmp/nvimsocket
        end
        set -gx NVR_CMD "neovide -- --listen '$NVIM_LISTEN_ADDRESS'"

        nvr -s --remote "$file"
    end
end

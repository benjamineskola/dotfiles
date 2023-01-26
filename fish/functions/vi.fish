function vi --wraps nvim
    set count 1
    set -l hashed_files

    for file in $argv
        set dirname (dirname -- $file)
        set -gx GIT_ROOT (pushd $dirname; git rev-parse --show-toplevel 2>/dev/null; popd)

        if [ -n "$GIT_ROOT" ]
            set -gx NVIM_LISTEN_ADDRESS /tmp/nvimsocket-(echo "$GIT_ROOT" | sha256sum | cut -d ' ' -f 1)
        else
            set -gx NVIM_LISTEN_ADDRESS /tmp/nvimsocket
            set -g GIT_ROOT $dirname
        end
        set -gx NVR_CMD "neovide -- --listen '$NVIM_LISTEN_ADDRESS'"

        set -a hashed_files "$NVIM_LISTEN_ADDRESS:$GIT_ROOT:$count:$file"

        set count (expr $count + 1)
    end
    set hashed_files (for hf in $hashed_files; echo $hf; end | sort)

    set -l commands
    set -l last_socket /dev/null

    for hf in $hashed_files
        set -l socket (string split -f 1 ":" $hf)
        set -l pwd (string split -f 2 ":" $hf)
        set -l file (string split -f 4 ":" $hf)

        if [ "$socket" != "$last_socket" ]
            set -a commands "$socket~~~$pwd"
        end
        set commands[-1] (printf "%s~~~%s" $commands[-1] $file)

        set last_socket $socket
    end

    for command in $commands
        set command (string split "~~~" $command)
        nvr -s --servername "$command[1]" +"cd $command[2]" --remote $command[3..]
    end
end

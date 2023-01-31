function vi --wraps nvim
    set -l sockets

    function varname
        string escape --style=var "commands_$argv[1]"
    end

    for file in $argv
        set -l dirname (dirname -- $file)
        set -l socketname /tmp/nvimsocket

        set -l git_root (pushd $dirname; git rev-parse --show-toplevel 2>/dev/null; popd)
        if test -n "$git_root"
            set socketname /tmp/nvimsocket_(echo "$git_root" | sha256sum | cut -d ' ' -f 1)
            set dirname $git_root
        end

        set -l _var (varname "$socketname")
        if ! contains $socketname $sockets
            set -a sockets $socketname
            set -f $_var $dirname
        end

        set -a $_var $file
    end

    for socket in $sockets
        set -l _var (varname "$socket")
        set -l params $$_var

        set -fx NVR_CMD "neovide -- --listen '$socket'"
        nvr -s --servername $socket +"cd $params[1]" --remote $params[2..]
    end
end

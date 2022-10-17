function dotenv_allowed
    if ! [ -f "$argv[1]" ]
        return 0
    end

    if fgrep -iq (sha256sum "$argv[1]") "$XDG_DATA_HOME/dotenv.allow"
        return 0
    end

    echo "$argv[1] not permitted" >&2
    echo "dotenv_allow to allow" >&2
    return 1
end

function dotenv_allowed
    if ! [ -f "$argv[1]" ] || ! [ -e "$XDG_DATA_HOME/dotenv.allow" ]
        return 0
    end

    if fgrep -iq (sha256sum "$argv[1]") "$XDG_DATA_HOME/dotenv.allow"
        return 0
    end

    if [ -z "$_DOTENV_WARNED" ]
        echo "$argv[1] not permitted" >&2
        bat "$argv[1]"
        echo "dotenv_allow to allow" >&2
    end
    return 1
end

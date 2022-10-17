function dotenv_load
    # if dotenv root is set and we're no longer inside it, unsource dotenv vars
    if [ "$PWD" != "$_DOTENV_ROOT" ] && ! string match -q "$_DOTENV_ROOT/*" "$PWD"
        echo "unexporting $_DOTENV_VARS"
        set -e $_DOTENV_VARS _DOTENV_VARS _DOTENV_ROOT
    end

    # if dotenv exists, source it and set dotenv root and dotenv vars
    if [ -e "$PWD/.env" ]
        set -l _DOTENV_FILES .env
        set -g _DOTENV_ROOT $PWD

        if ! [ -e "$XDG_DATA_HOME/dotenv.allow" ]
            touch "$XDG_DATA_HOME/dotenv.allow"
        end

        begin
            dotenv_allowed "$_DOTENV_ROOT/.env" &&
                dotenv_allowed "$_DOTENV_ROOT/.env.local"
        end || return

        if [ -n "$_DOTENV_VARS" ]
            return
        end

        set -g _DOTENV_VARS (cut -d '=' -f 1 .env)
        if [ -e "$PWD/.env.local" ]
            set -ga _DOTENV_VARS (cut -d '=' -f 1 .env.local)
            set -a _DOTENV_FILES .env.local
        end

        echo "exporting $_DOTENV_VARS from $_DOTENV_FILES"
        for var in $_DOTENV_VARS
            eval "export "(grep -h "^$var=" $_DOTENV_FILES | tail -n 1)
        end
    end
end

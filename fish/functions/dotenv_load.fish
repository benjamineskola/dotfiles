function dotenv_load
    # if dotenv root is set and we're no longer inside it, unsource dotenv vars
    if [ "$PWD" != "$_DOTENV_ROOT" ] && ! string match -q "$_DOTENV_ROOT/*" "$PWD"
        echo "unexporting $_DOTENV_VARS"
        set -e $_DOTENV_VARS _DOTENV_VARS _DOTENV_ROOT _DOTENV_WARNED
    end

    set -g _DOTENV_ROOT $PWD
    while [ $_DOTENV_ROOT != / ]
        if [ -e "$_DOTENV_ROOT/.env" ] || [ -e "$_DOTENV_ROOT/.env.local" ]
            break
        end

        set _DOTENV_ROOT (dirname $_DOTENV_ROOT)
    end

    if [ $_DOTENV_ROOT = / ]
        if set -q _DOTENV_VARS
            echo "unexporting $_DOTENV_VARS"
            set -e $_DOTENV_VARS _DOTENV_VARS
        end
        set -e _DOTENV_ROOT _DOTENV_WARNED
        return
    end

    # if dotenv exists, source it and record dotenv vars for unsetting later
    set -l _DOTENV_FILES

    if ! dotenv_allowed "$_DOTENV_ROOT/.env" || ! dotenv_allowed "$_DOTENV_ROOT/.env.local"
        set -g _DOTENV_WARNED 1
        return
    end

    if set -q _DOTENV_VARS
        return
    end

    set -g _DOTENV_VARS
    for file in .env .env.local
        if [ -e $_DOTENV_ROOT/$file ]
            set -a _DOTENV_VARS (cut -d '=' -f 1 $_DOTENV_ROOT/$file)
            set -a _DOTENV_FILES $_DOTENV_ROOT/$file
            set vars_pattern (string join '|' $_DOTENV_VARS)
            eval "export "(egrep -h "^($vars_pattern)=" $_DOTENV_ROOT/$file | tail -n 1)
        end
    end

    echo "exporting $_DOTENV_VARS from $_DOTENV_FILES"
end

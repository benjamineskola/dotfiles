function _virtualenv_autoload
    if not status --is-interactive; or status --is-command-substitution
        return
    end

    set -l virtualenv_base $PWD
    while [ $virtualenv_base != / ]
        if [ -d $virtualenv_base/.venv ]
            break
        end
        set virtualenv_base (dirname $virtualenv_base)
    end

    if [ "$virtualenv_base" = / ]
        if functions -q deactivate
            echo "deactivating virtualenv $VIRTUAL_ENV"
            deactivate
        end
        return
    end

    if [ "$VIRTUAL_ENV" != "$virtualenv_base/.venv" ]
        if functions -q deactivate
            echo "deactivating virtualenv"
            deactivate
        end

        echo "activating virtualenv $virtualenv_base"
        . "$virtualenv_base/.venv/bin/activate.fish"
    end
end

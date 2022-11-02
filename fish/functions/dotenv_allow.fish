function dotenv_allow
    test -f "$_DOTENV_ROOT/.env" && sha256sum "$_DOTENV_ROOT/.env" >>"$XDG_DATA_HOME/dotenv.allow"
    test -f "$_DOTENV_ROOT/.env.local" && sha256sum "$_DOTENV_ROOT/.env.local" >>"$XDG_DATA_HOME/dotenv.allow"
    sort -f -k2 "$XDG_DATA_HOME/dotenv.allow" | uniq | sponge "$XDG_DATA_HOME/dotenv.allow"
    set -e _DOTENV_WARNED
    dotenv_load
end

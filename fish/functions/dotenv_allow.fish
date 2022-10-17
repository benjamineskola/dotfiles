function dotenv_allow
    test -f "$_DOTENV_ROOT/.env" && sha256sum "$_DOTENV_ROOT/.env" >>"$XDG_DATA_HOME/dotenv.allow"
    test -f "$_DOTENV_ROOT/.env.local" && sha256sum "$_DOTENV_ROOT/.env.local" >>"$XDG_DATA_HOME/dotenv.allow"
    sort -uf -k2 "$XDG_DATA_HOME/dotenv.allow" | sponge "$XDG_DATA_HOME/dotenv.allow"
    dotenv_load
end

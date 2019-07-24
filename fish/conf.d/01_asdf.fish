set -gx ASDF_CONFIG_FILE "$XDG_CONFIG_HOME/asdfrc"
set -gx ASDF_DEFAULT_TOOL_VERSIONS_FILENAME "$XDG_CONFIG_HOME/tool-versions"
set -gx ASDF_DATA_DIR "$XDG_DATA_HOME/asdf"

. /usr/local/opt/asdf/asdf.fish

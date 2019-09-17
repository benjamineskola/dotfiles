set -g FZF_FIND_FILE_COMMAND "fd --hidden -E \"{.git,.Trash,Library,Movies,Music,Pictures}\" --type f . \$dir"
set -g FZF_OPEN_COMMAND "fd --hidden -E \"{.git,.Trash,Library,Movies,Music,Pictures}\" --type f . \$dir"

set -U FZF_LEGACY_KEYBINDINGS 0

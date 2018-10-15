autoload -U compinit
compinit -u -d "$XDG_CACHE_HOME/zcompdump"

## case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# don't include random latex output in completion for editors.
zstyle ':completion:*:*:(vi|vim|nvim|vimr|emacs(client|)|subl|atom):*:*files' ignored-patterns '*.(aux|dvi|log|ps|pdf|bbl|toc|lot|lof|bcf|blg|fdb_latexmk|fls|run.xml|out)'

# specific completion for custom git functions
compdef _git-branch gbr

WORDCHARS=${WORDCHARS/\//}

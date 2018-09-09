for config in ~/.zsh/*.zsh; do
	source "$config"
done

setopt check_jobs
setopt nobeep
setopt auto_cd auto_pushd pushd_silent
setopt extended_glob glob_dots
setopt correct

mkdir -p "$XDG_CACHE_HOME"

## syntax
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias vi=vim
if has_command vimr; then
	alias vim="vimr -n"
elif has_command nvim; then
	alias vim=nvim
fi

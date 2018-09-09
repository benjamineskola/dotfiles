if has_command nvim; then
	export EDITOR=nvim
else
	export EDITOR=vim
fi

export VISUAL=$EDITOR
alias vi=$EDITOR
alias vim=$EDITOR

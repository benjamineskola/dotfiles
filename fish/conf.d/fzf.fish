bind \eo __fzf_open_file
bind \ec __fzf_cd

set -x FZF_DEFAULT_OPTS "--cycle --layout=reverse --border --height 90% --preview-window=wrap:bottom:50%"

set --universal fzf_fish_custom_keybindings

# based on conf.d/fzf.fish from fzf.fish itself
bind \cr '__fzf_search_history'
bind \cv '__fzf_search_shell_variables'
# The following three key binding use Alt as an additional modifier key to avoid conflicts
bind \e\cl '__fzf_search_git_log'
bind \e\cs '__fzf_search_git_status'
bind \e\cf '__fzf_search_current_dir'

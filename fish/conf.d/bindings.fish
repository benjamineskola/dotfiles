# alt-shift-. to insert entire previous commandline
bind \e\> 'commandline -i "$history[1]"'

# approximate bash/zsh history expansions
bind '!$' history-token-search-backward
bind '!!' 'commandline -i "$history[1]"'

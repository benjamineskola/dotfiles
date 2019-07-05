eval (~/.config/scripts/xdg.sh)

mkdir -p $XDG_CACHE_HOME

source /usr/local/share/chruby/chruby.fish
chruby ruby 2

function iterm2_prompt_mark
end

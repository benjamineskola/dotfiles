if not functions -q fundle
    eval (curl -sfL https://git.io/fundle-install)
end

fundle plugin Gazorby/fish-abbreviation-tips
fundle plugin 'PatrickF1/fzf.fish'
fundle plugin benjamineskola/fish-git
fundle plugin 'jorgebucaran/autopair.fish'
fundle plugin 'kidonng/zoxide.fish'
fundle plugin pure-fish/pure
fundle init

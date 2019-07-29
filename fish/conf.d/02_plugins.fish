if not functions -q fundle
    eval (curl -sfL https://git.io/fundle-install)
end
fundle plugin benjamineskola/fish-git
fundle plugin jethrokuan/fzf
fundle plugin rafaelrinaldi/pure
fundle plugin sentriz/fish-pipenv
test -f ~/.config/fish/fundle/rafaelrinaldi/pure/fish_prompt.fish
and mv ~/.config/fish/fundle/rafaelrinaldi/pure/{*.fish,conf.d/}
fundle init

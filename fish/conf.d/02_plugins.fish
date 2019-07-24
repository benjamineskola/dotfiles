if not functions -q fundle
    eval (curl -sfL https://git.io/fundle-install)
end
fundle plugin benjamineskola/fish-git
fundle plugin jethrokuan/fzf
fundle plugin matchai/spacefish
fundle plugin sentriz/fish-pipenv
fundle init

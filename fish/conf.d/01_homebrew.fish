if test (uname -p) = arm
    set -gx HOMEBREW_PREFIX /opt/homebrew
    eval ($HOMEBREW_PREFIX/bin/brew shellenv)
else
    set -gx HOMEBREW_PREFIX /usr/local
end

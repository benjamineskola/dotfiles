if [ (uname -s) = Darwin ]
    if [ (uname -p) = arm ]
        set HOMEBREW_PREFIX /opt/homebrew
    else
        set HOMEBREW_PREFIX /usr/local
    end
    eval ($HOMEBREW_PREFIX/bin/brew shellenv)
end

if [ $OS = Darwin ]
    if [ $ARCH = arm ]
        set HOMEBREW_PREFIX /opt/homebrew
    else
        set HOMEBREW_PREFIX /usr/local
    end
    eval ($HOMEBREW_PREFIX/bin/brew shellenv)
end

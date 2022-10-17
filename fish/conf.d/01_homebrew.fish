if [ $OS = Darwin ]
    eval (/opt/homebrew/bin/brew shellenv)
end

set -gx HOMEBREW_BUNDLE_FILE $XDG_CONFIG_HOME/Brewfile

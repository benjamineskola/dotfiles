set -gx ASDF_DATA_DIR "$XDG_DATA_HOME/asdf"

if [ $OS = Darwin ]
    . (brew --prefix asdf)/libexec/asdf.fish
else
    if [ -d $HOME/.asdf ]
        . ~/.asdf/asdf.fish
    end
end

set -gx ASDF_CONFIG_FILE "$XDG_CONFIG_HOME/asdfrc"
set -gx ASDF_DEFAULT_TOOL_VERSIONS_FILENAME "$XDG_CONFIG_HOME/tool-versions"

set -gx ASDF_GEM_DEFAULT_PACKAGES_FILE "$XDG_CONFIG_HOME/default-gems.txt"
set -gx ASDF_PYTHON_DEFAULT_PACKAGES_FILE "$XDG_CONFIG_HOME/requirements.txt"
set -gx ASDF_NPM_DEFAULT_PACKAGES_FILE "$XDG_CONFIG_HOME/default-npm-packages.txt"

if type -q asdf
    if asdf where haskell >/dev/null 2>&1
        set -gx CABAL_CONFIG $XDG_CONFIG_HOME/cabal.conf
        set -gx CABAL_DIR (asdf where haskell)/cabal
        set -a fish_user_paths $CABAL_DIR/bin
    end

    if asdf where rust >/dev/null 2>&1
        set -gx RUSTUP_HOME (asdf where rust)
    end

    source (dirname (type -p asdf))/../../share/fish/vendor_completions.d/asdf.fish
end

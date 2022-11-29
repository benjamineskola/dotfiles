function ruby-install --wraps=ruby-install
    set -l RUBY_TMP (mktemp -d)
    if brew --prefix capstone >/dev/null 2>&1
        export CXXFLAGS="-I"(brew --prefix capstone)"/include"
        export LDFLAGS="-L"(brew --prefix capstone)"/lib"
    end
    command ruby-install -r "$RUBIES_DIR" -s "$RUBY_TMP" $argv -- --enable-shared
end

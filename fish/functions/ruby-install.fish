function ruby-install --wraps=ruby-install
    set -l RUBY_TMP (mktemp -d)
    command ruby-install -r "$RUBIES_DIR" -s "$RUBY_TMP" $argv
end

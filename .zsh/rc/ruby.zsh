chruby $(cat ~/.ruby-version)

test -n "$(find ~ -maxdepth 1 -name .rubocop.yml -mtime +1)" &&
  curl https://raw.githubusercontent.com/thoughtbot/guides/master/style/ruby/.rubocop.yml > .rubocop.yml

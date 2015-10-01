# -*- ruby -*-

tap 'caskroom/cask'
tap 'caskroom/fonts'
tap 'homebrew/bundle'

brew 'awscli'
brew 'brew-cask'
brew 'chruby'
brew 'colordiff'
brew 'coreutils'
# brew 'gcc48' # for ruby 1.9
brew 'heroku-toolbelt'
brew 'hub'
brew 'jq'
brew 'mobile-shell'
brew 'moreutils'
brew 'python3'
brew 'rename'
brew 'ruby-install'
brew 'rust'
brew 'the_silver_searcher'
brew 'tree'


# for ruby
brew 'gdbm'
brew 'libffi'
brew 'libyaml'
brew 'openssl'
brew 'readline'

cask 'alfred'
cask 'atom'
cask 'dropbox'
cask 'flux'
cask 'font-source-code-pro'
cask 'google-chrome'
cask 'iterm2'
cask 'steam'
cask 'vagrant'
cask 'virtualbox'

case ENV['HOSTNAME']
  when 'ELSLABM-155889'
    brew 'mysql' # for libmagi
    cask 'packer'
    cask 'viscosity'
  when 'Benjamins-MacBook-Pro'
    cask 'mactex'
    cask 'skype'
    cask 'vlc'
    cask 'tunnelbear'
end

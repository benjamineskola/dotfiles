export PATH=$HOME/bin:$PATH
. /usr/local/share/chruby/chruby.sh
. /usr/local/share/chruby/auto.sh
chruby ruby "$(cat ~/.ruby-version)"

alias be "bundle exec"
alias bl "bundle list"
alias bp "bundle package"
alias bo "bundle open"
alias bout "bundle outdated"
alias bu "bundle update"
alias bi "bundle install --jobs="(sysctl -n hw.ncpu)
alias bcn "bundle clean"

# this list of commands from oh-my-zsh https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/bundler/bundler.plugin.zsh
set bundled_commands annotate cap capify cucumber foodcritic guard hanami irb jekyll kitchen knife middleman nanoc pry puma rackup rainbows rake rspec rubocop shotgun sidekiq spec spork spring strainer tailor taps thin thor unicorn unicorn_rails
for cmd in $bundled_commands
    # see ~/.config/fish/functions/run_with_bundler.fish
    alias $cmd "run_with_bundler $cmd"
end

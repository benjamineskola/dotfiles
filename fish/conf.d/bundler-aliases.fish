alias be "bundle exec"
alias bl "bundle list"
alias bp "bundle package"
alias bo "bundle open"
alias bout "bundle outdated"
alias bu "bundle update"
alias bi "bundle install --jobs="(sysctl -n hw.ncpu)
alias bcn "bundle clean"

function _run_with_bundler
    set check_dir "$PWD"
    while [ "$check_dir" != "/" ]
        if [ -f "$check_dir/Gemfile" -o -f "$check_dir/gems.rb" ]
            bundle exec $argv
            return
        end
        set check_dir (dirname "$check_dir")
    end
    command $argv
end

# this list of commands from oh-my-zsh https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/bundler/bundler.plugin.zsh
set bundled_commands annotate cap capify cucumber foodcritic guard hanami irb jekyll kitchen knife middleman nanoc pry puma rackup rainbows rake rspec rubocop shotgun sidekiq spec spork spring strainer tailor taps thin thor unicorn unicorn_rails
for cmd in $bundled_commands
    alias $cmd "_run_with_bundler $cmd"
end

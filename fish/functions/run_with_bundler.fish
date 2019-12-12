# Defined in /Users/benjamineskola/.config/fish/conf.d/bundler-aliases.fish @ line 10
function run_with_bundler
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

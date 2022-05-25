set -x BUNDLE_USER_CACHE "$XDG_CACHE_HOME/bundler"
set -x BUNDLE_USER_HOME "$XDG_CONFIG_HOME/bundler"

set -x EDITOR nova
set -x VISUAL "nova -w"
set -x GIT_EDITOR nvim
set -x LESS -ImRswFX
set -x LESSHISTFILE "$XDG_CACHE_HOME/less_history"
set -x NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npmrc"

eval ({/usr/local,/opt/homebrew}/bin*/brew shellenv)

set -gx ASDF_CONFIG_FILE "$XDG_CONFIG_HOME/asdfrc"
set -gx ASDF_DEFAULT_TOOL_VERSIONS_FILENAME "$XDG_CONFIG_HOME/tool-versions"
set -gx ASDF_DATA_DIR "$XDG_DATA_HOME/asdf"

set -gx ASDF_GEM_DEFAULT_PACKAGES_FILE "$XDG_CONFIG_HOME/default-gems.txt"
set -gx ASDF_PYTHON_DEFAULT_PACKAGES_FILE "$XDG_CONFIG_HOME/requirements.txt"
set -gx ASDF_NPM_DEFAULT_PACKAGES_FILE "$XDG_CONFIG_HOME/default-npm-packages.txt"

set -gx CABAL_CONFIG $XDG_CONFIG_HOME/cabal.conf
set -gx CABAL_DIR (asdf where haskell)/cabal

set -gx RUSTUP_HOME (asdf where rust)

. (brew --prefix asdf)/libexec/asdf.fish

set -a fish_user_paths ~/bin $CABAL_DIR/bin

if status is-interactive
    alias curl 'curl -gkLsS'
    alias fdd 'fd .'
    alias fdg 'fd -g'
    alias fetch 'curl -gkLO'
    alias grep egrep
    alias less bat
    alias tf 'tail -F'

    alias exa 'exa --git -b'
    alias ls exa
    alias ll 'ls -l'
    alias la 'ls -a'
    alias lal 'ls -la'
    alias lsd 'ls -d'

    alias vi nvim
    alias vim nvim

    alias listcops 'rubocop -fo'
    alias openports 'lsof -nP -iTCP -sTCP:LISTEN'
    alias fontname 'fc-scan --format "%{postscriptname}\n"'

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

    alias dj 'run_with_virtualenv python manage.py'
    alias djs 'dj shell_plus'
    alias djrs 'dj runserver'
    alias djmm 'dj makemigrations'
    alias djm 'dj migrate'
    alias djcsu 'dj createsuperuser'

    alias gl glgga
    alias gmv 'git mv'
    alias gpr git-pr
    alias grsp 'grs -p'
    alias gswm gcm

    for cmd in mypy pytest invoke
        alias $cmd "run_with_virtualenv $cmd"
    end

    # alt-shift-. to insert entire previous commandline
    bind \e\> 'commandline -i "$history[1]"'
    bind \eo _fzf_search_directory
    set fzf_dir_opts "--bind=enter:execute-silent($EDITOR {})+abort,alt-enter:accept,alt-v:execute(nvim {} &>/dev/tty)+abort"
    set fzf_fd_opts --hidden --follow --exclude "{.git,.Trash,Library,Movies,Music,Pictures}"
    bind \ec __fzf_cd
end

function set_dark_mode --on-event fish_preexec
    if dark_mode
        if test "$BAT_THEME" != gruvbox-dark
            osascript -e 'tell application "iTerm2"
                launch API script named "iterm_set_font_light.py"
                end tell' &

            set -gx BAT_THEME gruvbox-dark
        end
    else
        if test "$BAT_THEME" != gruvbox-light
            osascript -e 'tell application "iTerm2"
                launch API script named "iterm_set_font_regular.py"
                end tell' &
            set -gx BAT_THEME gruvbox-light
        end
    end
end

starship init fish | source

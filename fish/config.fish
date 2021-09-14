if status is-interactive
    set -x BUNDLE_USER_CACHE "$XDG_CACHE_HOME/bundler"
    set -x BUNDLE_USER_HOME "$XDG_CONFIG_HOME/bundler"

    set -x EDITOR 'command mvim --remote-silent'
    set -x VISUAL vim
    set -x GIT_EDITOR 'command mvim --remote-wait-silent'
    set -x LESS -ImRswFX
    set -x LESSHISTFILE "$XDG_CACHE_HOME/less_history"
    set -x NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npmrc"
    set -x HEROKU_APP eskola-booklogger
    set -x VIMINIT 'let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

    set -a fish_user_paths ~/bin

    if test (uname -p) = arm
        set -gx HOMEBREW_PREFIX /opt/homebrew
        eval ($HOMEBREW_PREFIX/bin/brew shellenv)
    else
        set -gx HOMEBREW_PREFIX /usr/local
    end

    set -gx ASDF_CONFIG_FILE "$XDG_CONFIG_HOME/asdfrc"
    set -gx ASDF_DEFAULT_TOOL_VERSIONS_FILENAME "$XDG_CONFIG_HOME/tool-versions"
    set -gx ASDF_DATA_DIR "$XDG_DATA_HOME/asdf"

    set -gx ASDF_GEM_DEFAULT_PACKAGES_FILE "$XDG_CONFIG_HOME/default-gems.txt"
    set -gx ASDF_PYTHON_DEFAULT_PACKAGES_FILE "$XDG_CONFIG_HOME/requirements.txt"
    set -gx ASDF_NPM_DEFAULT_PACKAGES_FILE "$XDG_CONFIG_HOME/default-npm-packages.txt"

    . $HOMEBREW_PREFIX/opt/asdf/asdf.fish

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

    alias vi vim
    alias vim vim
    alias mvim 'mvim --remote-silent'

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

    alias dj 'run_with_poetry python manage.py'
    alias djs 'dj shell_plus'
    alias djrs 'dj runserver'
    alias djmm 'dj makemigrations'
    alias djm 'dj migrate'
    alias djcsu 'dj createsuperuser'

    alias gl glgg
    alias gmv 'git mv'
    alias gpr git-pr
    alias grsp 'grs -p'
    alias gswm gcm

    alias mypy 'run_with_poetry mypy'
    alias pytest 'run_with_poetry pytest'

    # alt-shift-. to insert entire previous commandline
    bind \e\> 'commandline -i "$history[1]"'
    bind \eo __fzf_open_file
    bind \e\co __fzf_insert_file
    bind \ec __fzf_cd

    set -x FZF_DEFAULT_OPTS "--cycle --layout=reverse --border --height 90% --preview-window=wrap:bottom:50%"

    set hydro_color_duration yellow
    set hydro_color_git magenta
    set hydro_color_prompt green
    set hydro_color_pwd cyan

    if ! ssh-add -lq >/dev/null && ! test -f $HOME/.ssh/askpass-lock
        touch $HOME/.ssh/askpass-lock
        if type -q ssh-askpass
            ssh-add </dev/null
        else
            ssh-add
        end
        rm $HOME/.ssh/askpass-lock
    end

    function merge_history --on-event fish_prompt
        history merge
    end
end

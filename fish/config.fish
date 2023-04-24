set -gx BUNDLE_USER_CACHE "$XDG_CACHE_HOME/bundler"
set -gx BUNDLE_USER_HOME "$XDG_CONFIG_HOME/bundler"

set -gx EDITOR hx
set -gx VISUAL hx
set -gx GIT_EDITOR hx

set -gx LESS "-ImRswFX --mouse"
set -gx LESSHISTFILE "$XDG_CACHE_HOME/less_history"
set -gx MANPAGER 'col -bx | bat -l man -p'

set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx CARGO_INSTALL_ROOT $CARGO_HOME
set -gx GOPATH $XDG_DATA_HOME/go
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npmrc"
set -gx PYENV_ROOT $XDG_DATA_HOME/pythons
set -gx RUBIES_DIR $XDG_DATA_HOME/rubies
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup
set -gx TFENV_CONFIG_DIR "$XDG_DATA_HOME/tfenv"
set -gx YARN_PREFIX $XDG_DATA_HOME/yarn

set -gx ANSIBLE_HOME $XDG_CONFIG_HOME/ansible
set -gx ANSIBLE_CONFIG $ANSIBLE_HOME/ansible.cfg

set -gx VIMINIT 'let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

if [ $OS = Darwin ]
    # Secretive Config
    set -gx SSH_AUTH_SOCK /Users/ben/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
end

fish_add_path -g -p ~/bin
fish_add_path -g -p $CARGO_HOME/bin
fish_add_path -g -p $GOPATH/bin
fish_add_path -g -p $YARN_PREFIX/bin

fish_add_path -g -a /usr/local/*bin

if status is-interactive
    alias curl 'curl -gkLsS'
    alias fdd 'fd .'
    alias fdg 'fd -g'
    alias fetch 'curl -gkLO'
    alias grep egrep
    type -fq hexyl && alias hd hexyl || alias hd 'hexdump -Cvv'
    alias less bat
    alias psed 'perl -0777 -p -e'
    type -fq rg || alias rg 'grep -ri'
    alias sed 'sed -E'
    alias tf 'tail -F'
    alias mdless 'mdless --width 72'

    alias exa 'exa --git -b'
    type -fq exa && alias ls exa
    alias ll 'ls -l'
    alias la 'ls -a'
    alias lal 'ls -la'
    alias lsd 'ls -d'

    alias vi hx
    alias vim hx
    alias nvim hx
    alias neovide hx

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

    alias dj 'python manage.py'
    alias djs 'dj shell_plus'
    alias djrs 'dj runserver'
    alias djmm 'dj makemigrations'
    alias djm 'dj migrate'
    alias djcsu 'dj createsuperuser'

    alias gfu git-fixup
    alias gl glgg
    alias glgp 'glg -p --pretty=medium'
    alias gmv 'git mv'
    alias grsp 'grs -p'
    alias gswm gcm
    alias gs 'fish_command_not_found gs' # i never want ghostscript

    # alt-shift-. to insert entire previous commandline
    bind \e\> 'commandline -i "$history[1]"'
    bind \eo _fzf_search_directory
    set fzf_dir_opts "--bind=enter:become(exec $EDITOR {} &>/dev/tty),alt-enter:accept"
    set fzf_fd_opts --hidden --follow --exclude "{.git,.Trash,Library,Movies,Music,Pictures}"
    bind \ec __fzf_cd

    set pure_color_primary cyan
    set pure_color_info magenta
    set pure_color_success green
    set pure_symbol_prompt '$'

    fnm env --use-on-cd --version-file-strategy recursive | source
else
    # non-interactive shells only
    fnm env --version-file-strategy recursive | source
end

function _dotenv_hook --on-event fish_prompt
    dotenv_load
end

function _virtualenv_hook --on-variable PWD
    _virtualenv_autoload
end
_virtualenv_autoload

pyenv init - | source

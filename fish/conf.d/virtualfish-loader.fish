set -g VIRTUALFISH_HOME $XDG_DATA_HOME/virtualenvs
grep -q '^pip$' $VIRTUALFISH_HOME/global_requirements.txt || echo pip >>$VIRTUALFISH_HOME/global_requirements.txt

set -g VIRTUALFISH_VERSION 2.5.4
set -g VIRTUALFISH_PYTHON_EXEC $HOME/Library/asdf/shims/python
source $HOME/Library/asdf/installs/python/*/lib/python3.*/site-packages/virtualfish/virtual.fish
source $HOME/Library/asdf/installs/python/*/lib/python3.*/site-packages/virtualfish/global_requirements.fish
source $HOME/Library/asdf/installs/python/*/lib/python3.*/site-packages/virtualfish/auto_activation.fish
emit virtualfish_did_setup_plugins

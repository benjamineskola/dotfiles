set -gx VIRTUALFISH_HOME $XDG_DATA_HOME/virtualenvs
mkdir -p $VIRTUALFISH_HOME

ln -sf $XDG_CONFIG_HOME/vf-requirements $VIRTUALFISH_HOME/global_requirements.txt

set -g VIRTUALFISH_VERSION 2.5.4
set -g VIRTUALFISH_PYTHON_EXEC $XDG_DATA_HOME/pythons/shims/python
set -g SITE_PACKAGES (fd --prune site-packages $XDG_DATA_HOME/pythons)
source $SITE_PACKAGES/virtualfish/virtual.fish
source $SITE_PACKAGES/virtualfish/global_requirements.fish
source $SITE_PACKAGES/virtualfish/auto_activation.fish
emit virtualfish_did_setup_plugins

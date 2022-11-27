#!/bin/sh
set -e
ansible-galaxy install -r "$XDG_CONFIG_HOME/ansible/requirements.yaml"
ansible-playbook -i "$XDG_CONFIG_HOME/ansible/hosts" "$XDG_CONFIG_HOME/ansible/macos.yaml"

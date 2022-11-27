#!/bin/sh
set -e
ansible-playbook -i "$XDG_CONFIG_HOME/ansible/hosts" "$XDG_CONFIG_HOME/ansible/macos.yaml"

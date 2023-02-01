#!/bin/sh
set -e
export ANSIBLE_HOME="$XDG_CONFIG_HOME/ansible"
export ANSIBLE_CONFIG="$ANSIBLE_HOME/ansible.cfg"
ansible-galaxy install -r "$ANSIBLE_HOME/requirements.yaml"
ansible-playbook "$ANSIBLE_HOME/main.yaml"

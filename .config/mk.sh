#!/bin/sh
set -eu

#for i in _ssh/known_hosts.d/*; do cat $i; done > _ssh/known_hosts
for i in _ssh/*.pub; do cat $i; done > _ssh/authorized_keys
host=$(hostname|cut -d. -f1)
test -f id_rsa_${host}.pub && ln -sf id_rsa_${host}.pub _ssh/id_rsa.pub
test -f ~/.private/ssh/id_rsa_${host} && ln -sf ../../.private/ssh/id_rsa_${host} _ssh/id_rsa
exit 0

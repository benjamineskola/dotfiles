#!/bin/sh
set -e

command -v brew && brew bundle --global install | grep -v '^Using'

command -v pip3 && test -x "$(command -v python3)" && pip3 install --upgrade pip && pip3 install -r requirements.txt | grep -v '^Requirement already satisfied'

command -v npm && xargs npm install --silent -g <npm-globals.txt

command -v go && xargs go get -u <go-globals.txt

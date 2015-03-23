# -*- sh -*-

OS=${OSTYPE%%[0-9.]*}

FQDN=$(hostname -f || hostname) # on solaris, hostname -f won't work
HOSTNAME=${FQDN%%.*}
DOMAIN=${FQDN#*.}
export HOSTNAME DOMAIN FQDN

export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.data

path=(~/bin /usr/local/bin /usr/local/sbin /usr/local/games /usr/bin /usr/sbin /usr/games /bin /sbin)

EDITOR=vi
if [[ -x "$(which vim)" ]]; then
	EDITOR=vim
fi
VISUAL=$EDITOR
export EDITOR VISUAL

export LESS="-ImRswFX"
if [[ -x "$(which lesspipe.sh)" ]]; then
	export LESSOPEN="|lesspipe.sh %s"
elif [[ -x "$(which lesspipe)" ]]; then
	export LESSOPEN="|lesspipe %s"
fi

export TZ=Europe/London

function parse_aws_config {
        sed -n "/profile $1/,/^\\s*\$/{s/ //g; s/^region/aws_region/; /=/p;}" $HOME/.aws/config
}

if [[ $HOSTNAME = mbuni ]]; then
	export GIT_AUTHOR_EMAIL=bma@mendeley.com
	export GIT_COMMITTER_EMAIL=bma@mendeley.com
	eval $(parse_aws_config work)
else
	eval $(parse_aws_config home)
fi
export AWS_ACCESS_KEY_ID=$aws_access_key_id
export AWS_SECRET_ACCESS_KEY=$aws_secret_access_key
export AWS_REGION=eu-west-1

test -e ~/.zsh/$OS/environment && . ~/.zsh/$OS/environment
test -e ~/.zsh/environment.after && . ~/.zsh/environment.after

. /usr/local/share/chruby/chruby.sh
. /usr/local/share/chruby/auto.sh
chruby 2

# $MirOS: src/bin/mksh/dot.mkshrc,v 1.54 2010/02/25 20:48:10 tg Exp $
#-
# Copyright (c) 2002, 2003, 2004, 2006, 2007, 2008, 2009, 2010
#	Thorsten Glaser <tg@mirbsd.org>
#
# Provided that these terms and disclaimer and all copyright notices
# are retained or reproduced in an accompanying document, permission
# is granted to deal in this work without restriction, including un-
# limited rights to use, publicly perform, distribute, sell, modify,
# merge, give away, or sublicence.
#
# This work is provided "AS IS" and WITHOUT WARRANTY of any kind, to
# the utmost extent permitted by applicable law, neither express nor
# implied; without malicious intent or gross negligence. In no event
# may a licensor, author or contributor be held liable for indirect,
# direct, other damage, loss, or other issues arising in any way out
# of dealing in the work, even if advised of the possibility of such
# damage or existence of a defect, except proven that it results out
# of said person's immediate fault when using the work as intended.
#-

# Berkeley C shell compatible dirs, popd, and pushd functions
# Z shell compatible chpwd() hook, used to update DIRSTACK[0]
DIRSTACKBASE=$(realpath ~/. 2>&- || print -nr -- "$HOME")
set -A DIRSTACK
function chpwd {
	DIRSTACK[0]=$(realpath . 2>&- || print -r -- "$PWD")
	[[ $DIRSTACKBASE = ?(*/) ]] || \
	    DIRSTACK[0]=${DIRSTACK[0]/#$DIRSTACKBASE/~}
	:
}
chpwd .
#function cd {
	#builtin cd "$@"
	#chpwd "$@"
#}
function cd_csh {
	typeset d t=${1/#~/$DIRSTACKBASE}

	if ! d=$(builtin cd "$t" 2>&1); then
		print -u2 "${1}: ${d##*$t - }."
		return 1
	fi
	builtin cd "$t"
	chpwd "$t"
}
function dirs {
	typeset d
	typeset -i isnoglob=0 fl=0 fv=0 fn=0 cpos=0

	[[ $(set +o) == *@(-o noglob)@(| *) ]] && isnoglob=1
	set -o noglob
	while getopts ":lvn" d; do
		case $d {
		(l)	fl=1 ;;
		(v)	fv=1 ;;
		(n)	fn=1 ;;
		(*)	print -u2 'Usage: dirs [-lvn].'
			return 1 ;;
		}
	done
	shift $((OPTIND - 1))
	if (( $# > 0 )); then
		print -u2 'Usage: dirs [-lvn].'
		return 1
	fi
	if (( fv )); then
		fv=0
		while (( fv < ${#DIRSTACK[*]} )); do
			d=${DIRSTACK[fv]}
			(( fl )) && d=${d/#~/$DIRSTACKBASE}
			print -r -- "$fv	$d"
			let fv++
		done
	else
		fv=0
		while (( fv < ${#DIRSTACK[*]} )); do
			d=${DIRSTACK[fv]}
			(( fl )) && d=${d/#~/$DIRSTACKBASE}
			if (( fn && (cpos+=${#d}+1) >= 79 && ${#d} < 80 )); then
				print
				(( cpos = ${#d} + 1 ))
			fi
			print -nr -- "$d "
			let fv++
		done
		print
	fi
	(( isnoglob )) || set +o noglob
	return 0
}
function popd {
	typeset d fa
	typeset -i isnoglob=0 n=1

	[[ $(set +o) == *@(-o noglob)@(| *) ]] && isnoglob=1
	set -o noglob
	while getopts ":0123456789lvn" d; do
		case $d {
		(l|v|n)	fa="$fa -$d" ;;
		(+*)	n=2
			break ;;
		(*)	print -u2 'Usage: popd [-lvn] [+<n>].'
			return 1 ;;
		}
	done
	shift $((OPTIND - n))
	n=0
	if (( $# > 1 )); then
		print -u2 popd: Too many arguments.
		return 1
	elif [[ $1 = ++([0-9]) && $1 != +0 ]]; then
		if (( (n = ${1#+}) >= ${#DIRSTACK[*]} )); then
			print -u2 popd: Directory stack not that deep.
			return 1
		fi
	elif [[ -n $1 ]]; then
		print -u2 popd: Bad directory.
		return 1
	fi
	if (( ${#DIRSTACK[*]} < 2 )); then
		print -u2 popd: Directory stack empty.
		return 1
	fi
	unset DIRSTACK[n]
	set -A DIRSTACK -- "${DIRSTACK[@]}"
	cd_csh "${DIRSTACK[0]}" || return 1
	(( isnoglob )) || set +o noglob
	dirs $fa
}
function pushd {
	typeset d fa
	typeset -i isnoglob=0 n=1

	[[ $(set +o) == *@(-o noglob)@(| *) ]] && isnoglob=1
	set -o noglob
	while getopts ":0123456789lvn" d; do
		case $d {
		(l|v|n)	fa="$fa -$d" ;;
		(+*)	n=2
			break ;;
		(*)	print -u2 'Usage: pushd [-lvn] [<dir>|+<n>].'
			return 1 ;;
		}
	done
	shift $((OPTIND - n))
	if (( $# == 0 )); then
		if (( ${#DIRSTACK[*]} < 2 )); then
			print -u2 pushd: No other directory.
			return 1
		fi
		d=${DIRSTACK[1]}
		DIRSTACK[1]=${DIRSTACK[0]}
		cd_csh "$d" || return 1
	elif (( $# > 1 )); then
		print -u2 pushd: Too many arguments.
		return 1
	elif [[ $1 = ++([0-9]) && $1 != +0 ]]; then
		if (( (n = ${1#+}) >= ${#DIRSTACK[*]} )); then
			print -u2 pushd: Directory stack not that deep.
			return 1
		fi
		while (( n-- )); do
			d=${DIRSTACK[0]}
			unset DIRSTACK[0]
			set -A DIRSTACK -- "${DIRSTACK[@]}" "$d"
		done
		cd_csh "${DIRSTACK[0]}" || return 1
	else
		if ! [[ -e "$1" ]]; then
			print -u2 "pushd: No such file or directory: $1"
			(( isnoglob )) || set +o noglob
			return 1
		fi

		set -A DIRSTACK -- placeholder "${DIRSTACK[@]}"
		cd_csh "$1" || return 1
	fi
	(( isnoglob )) || set +o noglob
	#dirs $fa
}

function cd {
	if [ -z "$1" ]; then
		pushd "$DIRSTACKBASE"
	else
		pushd "$@"
	fi
}

[no-cd]
build $infile format="pdf":
	#!/bin/bash
	set -eo pipefail
	infile="$PWD/$infile"
	identifier=$(basename "$infile" .md)
	assignments_dir=$(dirname "$infile")
	outfile="$assignments_dir"/"$identifier".{{format}}
	bibfile=$(find_in_parent bibliography.yaml "$assignments_dir")
	declare -a extra_args
	if egrep -qi "/open university/" <<<"$infile"; then
		extra_args+=-dopen-university
	fi
	if [[ {{format}} = typ || {{format}} = pdf ]]; then
		extra_args+=(-t typst-citations)
	fi
	pandoc --bibliography "$bibfile" -ddefaults ${extra_args[*]} -o "$outfile" "$infile"
	open "$outfile"

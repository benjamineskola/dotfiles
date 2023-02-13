[no-cd]
build $infile format="pdf":
	#!/bin/bash
	set -eo pipefail
	infile="$PWD/$infile"
	identifier=$(basename "$infile" .md)
	assignments_dir=$(dirname "$infile")
	module_dir=$(dirname "$assignments_dir")
	outfile="$assignments_dir"/"$identifier".{{format}}
	bibfile=$(find_in_parent bibliography.yaml "$assignments_dir")
	if egrep -qi "/open university/" <<<"$infile"; then
		extra_args=(-dopen-university --variable header-includes="\\fancyhead[C]{$identifier}")
	fi
	pandoc --bibliography "$bibfile" -ddefaults ${extra_args[*]} -o "$outfile" "$infile"
	open "$outfile"

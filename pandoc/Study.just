build $infile format="pdf":
	#!/bin/sh
	set -e
	identifier=$(basename "$infile" .md)
	assignments_dir=$(dirname "$infile")
	module_dir=$(dirname "$assignments_dir")
	outfile="$assignments_dir"/"$identifier".{{format}}
	bibfile=$(find_in_parent bibliography.yaml "$assignments_dir")
	pandoc --bibliography "$bibfile" -ddefaults -o "$outfile" "$infile"
	open "$outfile"

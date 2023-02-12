build $infile format="pdf":
	#!/bin/sh
	set -e
	identifier=$(basename "$infile" .md)
	assignments_dir=$(dirname "$infile")
	module_dir=$(dirname "$assignments_dir")
	outfile="$assignments_dir"/"$identifier".{{format}}
	pandoc --bibliography "$module_dir/bibliography.yaml" -ddefaults -dopen-university --variable header-includes="\\fancyhead[C]{$identifier}" -o "$outfile" "$infile"
	open "$outfile"

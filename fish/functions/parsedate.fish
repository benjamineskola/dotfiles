# Defined in /Users/benjamineskola/.config/fish/functions/parsedate.fish @ line 2
function parsedate
	if test (count $argv) -gt 1
date -j -f $argv[1] $argv[2]
else
date -jr $argv[1]
end
end

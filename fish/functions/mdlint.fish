function mdlint --wraps='command pandoc -s -dmarkdown-lint' --description 'alias mdlint command pandoc -s -dmarkdown-lint'
    argparse w/write -- $argv
    if test (count $argv) -ge 2
        echo "Too many input files specified" >&2
        return 1
    else if not count $argv
        echo "No input file specified" >&2
        return 1
    end
    if test $_flag_write
        set -p argv -o $argv[1]
    end
    command pandoc -dmarkdown-lint $argv
end

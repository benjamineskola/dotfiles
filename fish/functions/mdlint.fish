function mdlint --wraps='remark' --description 'alias mdlint remark'
    # fix overzealous escapes of ~, ., and _
    # gfm only used for tables; easier to fix subscript.
    # TODO find a standalone table plugin or pandoc-compatible syntax
    set after_pattern 's/\\\([~._])/\1/g'
    argparse w/write -- $argv

    if test $_flag_write
        set files
        for file in $argv
            if test -d $file
                set -a files $file/**.md
            else if test -e $file
                set -a files $file
            end
        end

        remark -q $files -o
        sed -E -i '' $after_pattern $files
    else
        remark -q $argv | sed -E $after_pattern
    end
end

function mdlint --wraps='remark' --description 'alias mdlint remark'
    # fix overzealous escapes of ~, ., _, and &
    # gfm only used for tables; easier to fix subscript.
    # TODO find a standalone table plugin or pandoc-compatible syntax
    set after_pattern 's/\\\([~._&([])/\1/g'
    argparse w/write c/compact -- $argv

    set files
    for file in $argv
        if test -d $file
            set -a files $file/**.md
        else if test -e $file
            set -a files $file
        end
    end

    if empty $files
        return
    end
    if test $_flag_write
        remark -r $HOME/.remarkrc.yml -q $files -o
        sed -E -i '' $after_pattern $files

        if test $_flag_compact
            perl -0777 -i -pe 's/\n+#/\n\n#/g;s/(^|\n)(#+ .+)\n+/\n$1$2\n/g' $files
            sed -i '' '1{/^$/d;}' $files
            perl -0777 -i -pe 's/\n\n\n/\n\n/g' $files
            perl -0777 -i -pe 's/(\n#+ .*)\n\n+/\1\n/g' $files
        end
    else
        remark -r $HOME/.remarkrc.yml -q $files | sed -E $after_pattern
    end
end

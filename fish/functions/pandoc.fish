function pandoc --wraps pandoc
    argparse -i 'o/output=' -- $argv
    set inputfiles
    set inputdirs
    for arg in $argv
        if not string match -q -- '-*' "$arg"
            set -a inputfiles "$arg"
        end
    end

    set pandoc_args -ddefaults

    for inputfile in inputfiles
        set inputdir (dirname (realpath -- $inputfile))
        if not contains $inputdir $inputdirs
            set -a inputdirs $inputdir
        end
    end

    for inputdir in $inputdirs
        if string match -q "$HOME/Documents/Study/*" $inputdir
            set searchdir $inputdir
            while test $searchdir != /
                for filename in {(basename $inputdir),essay,bibliography,references}.y{,a}ml
                    if test -f $searchdir/$filename
                        set -p pandoc_args --bibliography $searchdir/$filename
                    end
                end
                set searchdir (dirname $searchdir)
            end
        end
    end

    for inputdir in $inputdirs
        set searchdir $inputdir
        while test $searchdir != /
            if test -f $searchdir/metadata.yaml
                set -p pandoc_args --metadata-file $searchdir/metadata.yaml
            end
            set searchdir (dirname $searchdir)
        end
    end


    for inputdir in $inputdirs
        if string match -q "$HOME/Documents/Study/Open University/*" $inputdir
            if not contains -- -dopen-university $pandoc_args
                set -a pandoc_args -dopen-university --variable header-includes='\fancyhead[C]{'(basename $PWD)'}'
            end
        end
    end

    if test -n "$_flag_output"
        set -a pandoc_args -o $_flag_output
    end
    command pandoc $pandoc_args $argv
end

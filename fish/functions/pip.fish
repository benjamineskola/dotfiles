function pip --wraps pip
    command pip $argv
    or return 1

    if test $argv[1] = install
        asdf reshim python
    end
end

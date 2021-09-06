function gem --wraps gem
    command gem $argv
    or return 1

    if test $argv[1] = install
        asdf reshim ruby
    end
end

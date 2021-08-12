function _gds_wrap
    if test "$argv[2]" = connect
        argparse 'e/environment=' -- $argv
        term_title "$argv[4]@$_flag_environment ($argv[3])"
        command gds govuk connect $argv[3] -e $_flag_environment $argv[4]
    else
        command gds $argv
    end
end

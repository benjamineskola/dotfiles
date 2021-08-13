function _gds_connect_wrap
    if set -q argv[3] && test -n "$argv[3]"
        set environment $argv[3]
    else
        set environment integration
    end
    gds govuk connect $argv[1] -e $environment $argv[2]
end

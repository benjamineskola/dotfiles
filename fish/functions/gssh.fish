function gssh
    if set -q argv[2]
        set environment $argv[2]
    else
        set environment integration
    end
    gds govuk connect ssh -e $environment $argv[1]
end

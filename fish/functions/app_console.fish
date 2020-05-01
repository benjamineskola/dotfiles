function app_console
    if set -q argv[2]
        set environment $argv[2]
    else
        set environment integration
    end
    gds govuk connect app-console -e $environment $argv[1]
end

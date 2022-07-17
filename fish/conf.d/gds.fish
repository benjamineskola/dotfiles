if test (string sub -l 3 $hostname) = GDS
    alias gdr govuk-docker-run
    alias do 'govuk-docker-run bundle exec'
    alias dobi 'govuk-docker-run bundle install'

    fish_add_path -g ~/govuk/govuk-docker/exe

    set -gx AWS_REGION eu-west-1

    functions -e gds

    abbr gssh gds govuk connect ssh --environment integration
    abbr app_console gds govuk connect app-console --environment integration
    abbr db_console gds govuk connect app-dbconsole --environment integration

    source $XDG_CONFIG_HOME/private/fish/work-private.fish
end

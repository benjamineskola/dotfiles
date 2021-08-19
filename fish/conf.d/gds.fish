if test (string sub -l 3 $hostname) = GDS
    alias gdr 'govuk-docker-run'
    alias do 'govuk-docker-run bundle exec'
    alias dobi 'govuk-docker-run bundle install'

    set -a fish_user_paths ~/govuk/govuk-docker/exe

    set -gx AWS_REGION eu-west-1

    alias gds _gds_wrap
end

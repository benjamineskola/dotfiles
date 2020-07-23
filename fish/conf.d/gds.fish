if test (string sub -l 3 $hostname) = GDS
    alias gdr 'govuk-docker-run'
    alias do 'govuk-docker-run bundle exec'
    alias dobi 'govuk-docker-run bundle install'

    functions --erase gds

    set fish_user_paths $fish_user_paths ~/govuk/govuk-docker/exe
end

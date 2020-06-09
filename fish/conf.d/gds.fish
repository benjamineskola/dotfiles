if test (string sub -l 3 $hostname) = GDS
    alias gdr 'govuk-docker-run'
    alias do 'govuk-docker-run bundle exec'
    alias dobi 'govuk-docker-run bundle install'

    functions --erase gds
end

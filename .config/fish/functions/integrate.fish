function integrate
    cd ~/Code/mydrive-integration-testing
    aws-runas production caffeinate bundle exec rspec
end

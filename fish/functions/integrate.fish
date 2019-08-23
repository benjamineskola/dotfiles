function integrate
    cd ~/Code/mydrive/integration-tests
    git pull --rebase
    bundle install
    aws-runas production caffeinate bundle exec rspec
    cd -
end

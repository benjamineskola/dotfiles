function deploy
    argparse 'a/all' -- $argv

    set -x BRANCH (git_current_branch)

    bundle install

    if test -n "$_flag_all"
        echo Deploying $branch to all environments...
        aws-runas production bin/ecs_deploy_all
    else
        if nonempty $argv
            set environment $argv[1]
        else
            set environment beetroot
        end
        echo Deploying $branch to $environment...
        aws-runas production bin/ecs_deploy $environment
    end
end

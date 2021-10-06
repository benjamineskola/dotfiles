function run_with_virtualenv
    set check_dir "$PWD"
    while [ "$check_dir" != / ]
        if [ -f "$check_dir/poetry.lock" ]
            poetry run $argv
            return
        else if [ -f "$check_dir/Pipfile.lock" ]
            pipenv run $argv
            return
        end
        set check_dir (dirname "$check_dir")
    end
    command $argv
end

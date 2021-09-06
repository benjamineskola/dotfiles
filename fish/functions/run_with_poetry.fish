function run_with_poetry
    set check_dir "$PWD"
    while [ "$check_dir" != / ]
        if [ -f "$check_dir/poetry.lock" ]
            poetry run $argv
            return
        end
        set check_dir (dirname "$check_dir")
    end
    command $argv
end

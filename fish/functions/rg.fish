function rg --wraps rg
    if isatty stdout
        command rg --smart-case --pretty $argv | command less
    else
        command rg --smart-case $argv
    end
end

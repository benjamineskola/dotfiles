function rg --description 'alias rg rg -S'
    if isatty stdout
        command rg --color=always --heading -S $argv | command less
    else
        command rg -S $argv
    end
end

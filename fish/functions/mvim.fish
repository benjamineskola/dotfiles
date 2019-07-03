function mvim
    if empty $argv
        command mvim
    else
        command mvim --remote-tab-silent $argv
    end
end

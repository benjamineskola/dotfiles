alias gl glgg
alias gmv 'git mv'
alias grm 'git rm'
alias gpr 'git-pr'
alias grsp 'git restore -p'

set _git_version (git --version | string match -r '[0-9.]+$' | string split .)
if test $_git_version[2] -gt 12
    alias gsw 'git switch'
    alias grs 'git restore'

    for i in gco gcb gcm gcd
        alias $i 'echo "Did you mean gsw (git switch) or grs (git restore)?"'
    end

    alias gswm 'gb | string match -q "* master"; and gsw master; or gsw main'
    alias gswc 'git switch -c'
end

set fish_user_paths $fish_user_paths /usr/local/share/git-core/contrib/diff-highlight/

if status --is-interactive && ! ssh-add -lq >/dev/null
    if ! test -f $HOME/.ssh/askpass-lock
        touch $HOME/.ssh/askpass-lock
        if type -q ssh-askpass
            ssh-add </dev/null
        else
            ssh-add
        end
        rm $HOME/.ssh/askpass-lock
    end
end

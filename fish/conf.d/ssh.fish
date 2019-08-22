if status --is-interactive && ! ssh-add -lq >/dev/null
    ssh-add
end

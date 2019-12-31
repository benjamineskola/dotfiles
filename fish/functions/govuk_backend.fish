function govuk_backend
    set command $argv[1]
    set app $argv[2]

    if test $app = publishing_api
        set app publishing-api
    end

    if test $app = whitehall
        set backend whitehall_backend
    else if test $app = publishing-api
        set backend publishing_api
    else
        set backend backend
    end

    ssh -Atq $GOVUK_JUMPBOX "ssh -Atq `govuk_node_list -c $backend --single-node` $command"
end

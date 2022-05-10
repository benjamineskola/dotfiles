function __fzf_cd --description 'Search the home directory using fzf and fd. Change to the selected directory'
    set open_status 0

    set --local -x fzf_dir_opts "--bind=enter:accept"
    set --local -a -x fzf_fd_opts --type d

    _fzf_search_directory
    commandline -f execute
end

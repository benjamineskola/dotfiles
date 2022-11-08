local M = {}

M.abbrev = function(mode, from, to, opts)
    if mode:len() ~= 1 then
        return
    end

    local cmd = "abbrev"
    if opts and opts.noreabbrev then
        cmd = "noreabbrev"
    end

    cmd = mode .. cmd
    vim.cmd({ cmd = cmd, args = { from, to } })
end

M.find_file_in_parent = function(filename, stop)
    if not stop then
        stop = vim.env.HOME
    end

    return vim.fs.find({ filename }, { stop = stop, upward = true })[1]
end

M.get_dir_with_file = function(filename)
    return vim.fs.dirname(M.find_file_in_parent(filename))
end

M.get_git_root = function()
    return M.get_dir_with_file(".git")
end

M.has_gemfile = function()
    local gemfile = M.find_file_in_parent("Gemfile", M.get_git_root())
    if gemfile then
        return gemfile
    end
    return false
end

M.has_rubocop = function()
    if M.find_file_in_parent(".rubocop.yml") then
        return true
    else
        local gemfile = M.has_gemfile()
        if gemfile then
            if os.execute("grep -q rubocop " .. vim.fn.shellescape(gemfile)) == 0 then
                return true
            end
        end
    end
    return false
end

return M

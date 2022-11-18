local M = {}

M.abbrev = function(mode, from, to, opts)
    if mode:len() ~= 1 then return end

    local cmd = "abbrev"
    if opts and opts.noreabbrev then cmd = "noreabbrev" end

    cmd = mode .. cmd
    vim.cmd({ cmd = cmd, args = { from, to } })
end

M.find_file_in_parent = function(filename, stop)
    if not stop then stop = vim.env.HOME end

    return vim.fs.find({ filename }, { stop = stop, upward = true })[1]
end

M.get_dir_with_file = function(filename) return vim.fs.dirname(M.find_file_in_parent(filename)) end

M.get_git_root = function() return M.get_dir_with_file(".git") end

return M

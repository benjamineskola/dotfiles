local M = {}

M.abbrev = function(mode, from, to, opts)
    if mode:len() ~= 1 then return end

    local cmd = "abbrev"
    if opts and opts.noreabbrev then cmd = "noreabbrev" end

    cmd = mode .. cmd
    vim.cmd({ cmd = cmd, args = { from, to } })
end

return M

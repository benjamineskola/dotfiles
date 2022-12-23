vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
    command = "wshada",
    group = vim.api.nvim_create_augroup("IncrementalShadaSave", { clear = true }),
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
    command = "setlocal nonumber norelativenumber",
    group = vim.api.nvim_create_augroup("terminal", { clear = true }),
})

vim.api.nvim_create_autocmd({ "DirChanged" }, {
    callback = function() vim.fn.system("zoxide add " .. vim.fn.shellescape(vim.fn.getcwd())) end,
    group = vim.api.nvim_create_augroup("zoxide", { clear = true }),
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    callback = function() vim.wo.colorcolumn = (vim.b.colorcolumn and tostring(vim.b.colorcolumn + 1) or "81") end,
    group = vim.api.nvim_create_augroup("colorcolumn", { clear = true }),
})

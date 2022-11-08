vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
    command = "wshada",
    group = vim.api.nvim_create_augroup("IncrementalShadaSave", { clear = true }),
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
    command = "setlocal nonumber norelativenumber",
    group = vim.api.nvim_create_augroup("terminal", { clear = true }),
})

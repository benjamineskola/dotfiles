vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
    command = "wshada",
    group = vim.api.nvim_create_augroup("IncrementalShadaSave", { clear = true }),
})

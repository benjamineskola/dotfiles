local M = {
    "simrat39/rust-tools.nvim",
    ft = { "rust", "toml" },
}

M.opts = {
    server = {
        on_attach = function()
            vim.api.nvim_create_autocmd({ "BufWritePre" }, {
                callback = function(opts)
                    vim.lsp.buf.format({ bufnr = opts.buf })
                    vim.cmd([[FormatWrite]])
                end,
                group = vim.api.nvim_create_augroup("FormatSync", { clear = true }),
            })
        end,
        ["rust-analyzer"] = { rustfmt = { extraArgs = { "+nightly" } } },
    },
}

return M

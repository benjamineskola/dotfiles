local remove_trailing_newlines = {
    exe = "perl",
    args = { "-007", "-pe", [[s/\\n+$/\\n/gs]] },
    stdin = true,
}

require("formatter").setup({
    filetype = {
        css = { require("formatter.filetypes.javascript").prettierd },
        fish = { require("formatter.filetypes.fish").fishindent },
        javascript = { require("formatter.filetypes.javascript").prettierd },
        lua = { require("formatter.filetypes.lua").stylua },
        markdown = { require("formatter.filetypes.markdown").prettierd },
        ruby = {
            function()
                if require("utils").has_rubocop() then
                    return require("formatter.filetypes.ruby").rubocop()
                end

                return require("formatter.filetypes.ruby").standardrb()
            end,
        },
        scss = { require("formatter.filetypes.javascript").prettierd },
        sh = { require("formatter.filetypes.sh").shfmt },
        typescript = { require("formatter.filetypes.typescript").prettierd },
        ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace,
            remove_trailing_newlines,
        },
    },
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        vim.cmd([[FormatWrite]])
    end,
    group = vim.api.nvim_create_augroup("autoformat", { clear = true }),
})

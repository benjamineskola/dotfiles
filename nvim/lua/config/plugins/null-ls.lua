local M = {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost" },
}

M.config = function()
    local null_ls = require("null-ls")
    local helpers = require("null-ls.helpers")

    local cargo_fix = helpers.make_builtin({
        factory = helpers.formatter_factory,
        generator_opts = { command = "cargo", args = { "clippy", "--fix", "--allow-dirty", "--allow-staged" } },
        filetypes = { "rust" }, -- table
        method = null_ls.methods.FORMATTING,
        meta = {},
    })

    null_ls.setup({
        sources = {
            null_ls.builtins.diagnostics.erb_lint,
            null_ls.builtins.diagnostics.fish,
            null_ls.builtins.diagnostics.markdownlint,
            null_ls.builtins.diagnostics.reek,
            null_ls.builtins.diagnostics.todo_comments,
            null_ls.builtins.diagnostics.tsc.with({ extra_filetypes = { "javascript" } }),
            null_ls.builtins.diagnostics.vint,

            cargo_fix,
            null_ls.builtins.formatting.erb_lint,
            null_ls.builtins.formatting.fish_indent,
            null_ls.builtins.formatting.prettierd.with({ filetypes = { "css", "html", "yaml", "markdown", "scss" } }),
            null_ls.builtins.formatting.rome.with({
                args = { "check", "--apply", "$FILENAME" },
                extra_filetypes = { "json" },
            }),
            null_ls.builtins.formatting.shfmt,
            null_ls.builtins.formatting.taplo,
            null_ls.builtins.formatting.trim_newlines,
            null_ls.builtins.formatting.trim_whitespace,
        },
        on_attach = require("config.plugins.lsp").default_on_attach,
    })
end

return M

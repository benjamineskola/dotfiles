local function on_attach(client)
    if client.resolved_capabilities.document_formatting then
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
end

local nls = require("null-ls")

nls.config({
    sources = {
        -- formatting
        nls.builtins.formatting.fish_indent, -- fish
        nls.builtins.formatting.gofumpt, -- go
        nls.builtins.formatting.goimports, -- go
        nls.builtins.formatting.golines, -- go
        nls.builtins.formatting.prettier.with({ filetypes = { "html", "json", "yaml", "javascript" } }), -- javascript etc
        nls.builtins.formatting.stylua, -- lua
        nls.builtins.formatting.black, -- python
        nls.builtins.formatting.isort, -- python
        nls.builtins.formatting.rubocop, -- ruby
        nls.builtins.formatting.shfmt, -- shell
        nls.builtins.formatting.shellharden, -- shell
        nls.builtins.formatting.trim_newlines,
        nls.builtins.formatting.trim_whitespace.with({ disabled_filetypes = { "markdown" } }),

        -- linting
        nls.builtins.diagnostics.golangci_lint, -- go
        nls.builtins.diagnostics.flake8.with({ extra_args = { "--config", "$XDG_CONFIG_HOME/flake8" } }), -- python
        nls.builtins.diagnostics.rubocop, -- ruby
        nls.builtins.diagnostics.shellcheck, -- shell
        nls.builtins.diagnostics.vint, -- vim
    },
})

require("lspconfig")["null-ls"].setup({
    on_attach = on_attach,
})

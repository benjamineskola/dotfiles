local nls = require("null-ls")

local b = nls.builtins
local h = require("null-ls.helpers")

nls.config({
    sources = {
        -- formatting
        b.formatting.fish_indent, -- fish
        b.formatting.gofumpt, -- go
        b.formatting.goimports, -- go
        b.formatting.golines, -- go
        b.formatting.prettier.with({ filetypes = { "html", "json", "yaml", "javascript" } }), -- javascript etc
        b.formatting.stylua, -- lua
        b.formatting.shfmt, -- shell
        b.formatting.shellharden, -- shell
        b.formatting.trim_newlines.with({ disabled_filetypes = { "haskell", "python" } }),
        b.formatting.trim_whitespace.with({ disabled_filetypes = { "haskell", "markdown", "python" } }),

        -- linting
        b.diagnostics.golangci_lint, -- go
        b.diagnostics.shellcheck, -- shell
        b.diagnostics.vint, -- vim

        h.conditional(function(utils)
            return utils.root_has_file("Gemfile")
                    and b.formatting.rubocop.with({
                        command = "bundle",
                        args = vim.list_extend({ "exec", "rubocop" }, b.formatting.rubocop._opts.args),
                    })
                or b.formatting.rubocop
        end),
        h.conditional(function(utils)
            return utils.root_has_file("Gemfile")
                    and b.diagnostics.rubocop.with({
                        command = "bundle",
                        args = vim.list_extend({ "exec", "rubocop" }, b.diagnostics.rubocop._opts.args),
                    })
                or b.diagnostics.rubocop
        end),
    },
})

require("lspconfig")["null-ls"].setup({
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd([[augroup FormatSync
                  autocmd!
                  autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
                  augroup END
        ]])
        end
    end,
})

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
        b.formatting.black, -- python
        b.formatting.isort, -- python
        b.formatting.shfmt, -- shell
        b.formatting.shellharden, -- shell
        b.formatting.trim_newlines,
        b.formatting.trim_whitespace.with({ disabled_filetypes = { "markdown" } }),

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

        h.conditional(function(utils)
            return utils.root_has_file("pyproject.toml")
                    and b.diagnostics.flake8.with({
                        command = "poetry",
                        args = vim.list_extend({ "run", "flakehell", "lint" }, b.diagnostics.flake8._opts.args),
                    })
                or b.diagnostics.flake8.with({ extra_args = { "--config", "$XDG_CONFIG_HOME/flake8" } })
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

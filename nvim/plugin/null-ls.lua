local nls = require("null-ls")

local b = nls.builtins

nls.setup({
    sources = {
        -- formatting
        b.formatting.fish_indent, -- fish
        b.formatting.prettier.with({ filetypes = { "html", "json", "yaml", "javascript" } }), -- javascript etc
        b.formatting.stylua, -- lua
        b.formatting.rubocop.with({ command = vim.fn.stdpath("config") .. "/helpers/rubocop" }),
        b.formatting.shfmt, -- shell
        b.formatting.trim_newlines.with({ disabled_filetypes = { "go", "haskell", "python" } }),
        b.formatting.trim_whitespace.with({ disabled_filetypes = { "go", "haskell", "markdown", "python" } }),

        -- linting
        b.diagnostics.golangci_lint, -- go
        b.diagnostics.luacheck.with({
            command = vim.fn.stdpath("cache")
                .. "/packer_hererocks/"
                .. string.gsub(jit.version, "LuaJIT ", "")
                .. "/bin/luacheck",
            args = vim.list_extend({ "--globals=jit", "--globals=vim" }, b.diagnostics.luacheck._opts.args),
        }), -- lua
        b.diagnostics.rubocop.with({ command = vim.fn.stdpath("config") .. "/helpers/rubocop" }),
        b.diagnostics.shellcheck, -- shell
        b.diagnostics.vint, -- vim
    },
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

local nls = require("null-ls")

local b = nls.builtins

local ruby_linter = function(filename, root)
    local lsputil = require("lspconfig.util")
    if
        filename:match("^" .. vim.fn.expand("~/govuk/")) or lsputil.path.exists(lsputil.path.join(root, ".rubocop.yml"))
    then
        return "rubocop"
    else
        return "standardrb"
    end
end

local dynamic_ruby_command = function(params)
    if not vim.b[params.bufnr].ruby_linter then
        vim.b[params.bufnr].ruby_linter = ruby_linter(params.bufname, params.root)
    end
    return vim.b[params.bufnr].ruby_linter
end

local dynamic_ruby_args = function(params, module)
    if dynamic_ruby_command(params) == "rubocop" then
        return vim.list_extend({ "exec", "rubocop" }, module.rubocop._opts.args)
    else
        return module.standardrb._opts.args
    end
end

nls.config({
    sources = {
        -- formatting
        b.formatting.fish_indent, -- fish
        b.formatting.gofumpt, -- go
        b.formatting.goimports, -- go
        b.formatting.golines, -- go
        b.formatting.prettier.with({ filetypes = { "html", "json", "yaml", "javascript" } }), -- javascript etc
        b.formatting.stylua, -- lua
        b.formatting.rubocop.with({
            dynamic_command = dynamic_ruby_command,
            args = function(params)
                return dynamic_ruby_args(params, b.formatting)
            end,
        }),
        b.formatting.shfmt, -- shell
        b.formatting.shellharden, -- shell
        b.formatting.trim_newlines.with({ disabled_filetypes = { "haskell", "python" } }),
        b.formatting.trim_whitespace.with({ disabled_filetypes = { "haskell", "markdown", "python" } }),

        -- linting
        b.diagnostics.golangci_lint, -- go
        b.diagnostics.luacheck.with({
            command = vim.fn.stdpath("cache")
                .. "/packer_hererocks/"
                .. string.gsub(jit.version, "LuaJIT ", "")
                .. "/bin/luacheck",
            args = vim.list_extend({ "--globals=jit", "--globals=vim" }, b.diagnostics.luacheck._opts.args),
        }), -- lua
        b.diagnostics.rubocop.with({
            dynamic_command = dynamic_ruby_command,
            args = function(params)
                return dynamic_ruby_args(params, b.diagnostics)
            end,
        }),
        b.diagnostics.shellcheck, -- shell
        b.diagnostics.vint, -- vim
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

local nls = require("null-ls")

local b = nls.builtins

local function has_rubocop(utils)
    return utils.root_has_file(".rubocop.yml")
end
local function hasnt_rubocop(utils)
    return not has_rubocop(utils)
end

nls.setup({
    sources = {
        -- formatting
        b.formatting.fish_indent, -- fish
        b.formatting.prettier.with({ filetypes = { "html", "json", "yaml", "javascript" } }), -- javascript etc
        b.formatting.stylua, -- lua
        b.formatting.rubocop.with({
            condition = has_rubocop,
            command = "bundle",
            args = vim.list_extend({ "exec", "rubocop" }, nls.builtins.formatting.rubocop._opts.args),
        }),
        b.formatting.standardrb.with({ condition = hasnt_rubocop }),
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
        b.diagnostics.rubocop.with({
            condition = has_rubocop,
            command = "bundle",
            args = vim.list_extend({ "exec", "rubocop" }, nls.builtins.formatting.rubocop._opts.args),
        }),
        b.diagnostics.standardrb.with({ condition = hasnt_rubocop }),
        b.diagnostics.shellcheck, -- shell
        b.diagnostics.vint, -- vim
    },
    on_attach = function(client)
        if client.server_capabilities.documentFormattingProvider then
            vim.cmd([[augroup FormatSync
                  autocmd!
                  autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
                  augroup END
        ]])
        end
    end,
})

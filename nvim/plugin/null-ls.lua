local nls = require("null-ls")

local b = nls.builtins

local function has_rubocop(utils)
    return utils.root_has_file(".rubocop.yml")
end

local function hasnt_rubocop(utils)
    return not has_rubocop(utils)
end

local function bundled_rubocop()
    local utils = require("null-ls.utils").make_conditional_utils()
    local gemfile = require("null-ls.utils").get_root() .. "/Gemfile"
    if utils.root_has_file("Gemfile") then
        return os.execute("grep -q rubocop " .. gemfile) == 0
    end
    return false
end

local function rubocop_args(type)
    local cmd = "rubocop"
    local args = type.rubocop._opts.args
    if bundled_rubocop() then
        cmd = "bundle"
        args = vim.list_extend({ "exec", "rubocop" }, args)
    end
    return {
        condition = has_rubocop,
        command = cmd,
        args = args,
    }
end

nls.setup({
    sources = {
        -- formatting
        b.formatting.fish_indent, -- fish
        b.formatting.prettierd.with({ disabled_filetypes = { "html" } }),
        b.formatting.stylua, -- lua
        b.formatting.rubocop.with(rubocop_args(b.formatting)),
        b.formatting.standardrb.with({ condition = hasnt_rubocop }),
        b.formatting.shfmt, -- shell
        b.formatting.trim_newlines.with({ disabled_filetypes = { "go", "haskell", "python" } }),
        b.formatting.trim_whitespace.with({ disabled_filetypes = { "go", "haskell", "markdown", "python" } }),

    },
    on_attach = function(client)
        if client.server_capabilities.documentFormattingProvider then
            vim.cmd([[augroup FormatSync
                  autocmd!
                  autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
                  augroup END
        ]])
        end
    end,
})

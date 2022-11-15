local lint = require("lint")

local ruby_linter = "standardrb"
if require("utils").has_rubocop() then ruby_linter = "rubocop" end

local standardrb = lint.linters.standardrb
lint.linters.standardrb = function()
    standardrb.ignore_exitcode = true
    return standardrb
end

require("lint").linters.tsc = function()
    return {
        cmd = "tsc",
        args = { "--noEmit", "--project", vim.fn.getcwd() },
        stdin = true,
        ignore_exitcode = true,
        parser = require("lint.parser").from_pattern(
            "(%g+)%((%d+),(%d+)%): (%a+) (%g+): (.+)",
            { "file", "lnum", "col", "severity", "code", "message" },
            {
                ["source"] = "tsc",
            }
        ),
    }
end

require("lint").linters_by_ft = {
    go = { "golangcilint" },
    javascript = { "tsc" },
    ruby = { ruby_linter },
    sh = { "shellcheck" },
    typescript = { "tsc" },
    vim = { "vint" },
}

vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost" }, {
    callback = function() lint.try_lint() end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "ruby", "typescript" },
    callback = function()
        vim.api.nvim_create_autocmd({ "TextChanged" }, {
            callback = function() lint.try_lint() end,
            group = vim.api.nvim_create_augroup("lint_ft_textchanged", { clear = true }),
        })
    end,
    group = vim.api.nvim_create_augroup("lint_ft_textchanged_setup", { clear = true }),
})
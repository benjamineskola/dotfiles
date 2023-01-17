local M = {
    "mfussenegger/nvim-lint",
    ft = {},
}

local linters = {
    javascript = { "tsc" },
    markdown = { "markdownlint" },
    sh = { "shellcheck" },
    typescript = { "tsc" },
    vim = { "vint" },
}

for k, _ in pairs(linters) do
    table.insert(M.ft, k)
end

M.config = function()
    local lint = require("lint")

    lint.linters.tsc = function()
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

    lint.linters_by_ft = linters
end

M.init = function()
    vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost" }, {
        callback = function() require("lint").try_lint() end,
        group = vim.api.nvim_create_augroup("lint", { clear = true }),
    })

    vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "ruby", "typescript" },
        callback = function()
            vim.api.nvim_create_autocmd({ "TextChanged" }, {
                callback = function() require("lint").try_lint() end,
                group = vim.api.nvim_create_augroup("lint_ft_textchanged", { clear = true }),
            })
        end,
        group = vim.api.nvim_create_augroup("lint_ft_textchanged_setup", { clear = true }),
    })
end

return M

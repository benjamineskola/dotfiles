local M = {
    "mhartington/formatter.nvim",
    cmd = { "FormatWrite" },
}

M.config = function()
    local util = require("formatter.util")

    local remove_trailing_newlines = {
        exe = "perl",
        args = { "-007", "-pe", [[s/\\n+$/\\n/gs]] },
        stdin = true,
    }

    local erb_lint = {
        exe = "erblint",
        args = { "--autocorrect", "--stdin", util.escape_path(util.get_current_buffer_file_path()) },
        stdin = true,
        ignore_exitcode = true,
        transform = function(text)
            while not vim.startswith(text[1], "====") do
                table.remove(text, 1)
            end
            table.remove(text, 1)
            return text
        end,
    }

    local rome_lint = {
        exe = "rome",
        args = { "check", "--apply-suggested" },
        tempfile_postfix = "." .. util.get_current_buffer_file_extension(),
    }

    local cargo_fix = {
        exe = "cargo",
        args = { "clippy", "--fix", "--allow-dirty", "--allow-staged" },
        ignore_exitcode = true,
        no_append = true,
    }

    require("formatter").setup({
        filetype = {
            css = { require("formatter.filetypes.css").prettierd },
            eruby = { erb_lint },
            fish = { require("formatter.filetypes.fish").fishindent },
            html = { require("formatter.filetypes.html").prettierd },
            javascript = { rome_lint },
            json = { require("formatter.filetypes.json").prettierd },
            lua = { require("formatter.filetypes.lua").stylua },
            markdown = { require("formatter.filetypes.markdown").prettierd },
            scss = { require("formatter.filetypes.css").prettierd },
            sh = { require("formatter.filetypes.sh").shfmt },
            rust = { cargo_fix },
            typescript = { rome_lint },
            yaml = { require("formatter.filetypes.yaml").prettierd },
            ["*"] = {
                require("formatter.filetypes.any").remove_trailing_whitespace,
                remove_trailing_newlines,
            },
        },
    })
end

M.init = function()
    if vim.bo.filetype ~= "rust" then
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                if vim.b.format == nil or vim.b.format == true or vim.b.format == 1 then vim.cmd([[FormatWrite]]) end
            end,
            group = vim.api.nvim_create_augroup("autoformat", { clear = true }),
        })
    end
end

return M

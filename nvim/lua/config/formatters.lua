local util = require("formatter.util")
local remove_trailing_newlines = {
    exe = "perl",
    args = { "-007", "-pe", [[s/\\n+$/\\n/gs]] },
    stdin = true,
}

local rome_lint = {
    exe = "rome",
    args = { "check", "--apply-suggested", util.escape_path(util.get_current_buffer_file_path()) },
    ignore_exitcode = true,
}

local rome_or_prettier = function(filetype)
    local utils = require("utils")
    if utils.find_file_in_parent("rome.json", utils.get_git_root()) then return rome_lint end

    return require("formatter.filetypes." .. filetype).prettierd
end

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

require("formatter").setup({
    filetype = {
        css = { require("formatter.filetypes.css").prettierd },
        eruby = { erb_lint },
        fish = { require("formatter.filetypes.fish").fishindent },
        html = { require("formatter.filetypes.html").prettierd },
        javascript = { rome_or_prettier("javascript") },
        json = { require("formatter.filetypes.json").prettierd },
        lua = { require("formatter.filetypes.lua").stylua },
        markdown = { require("formatter.filetypes.markdown").prettierd },
        scss = { require("formatter.filetypes.css").prettierd },
        sh = { require("formatter.filetypes.sh").shfmt },
        typescript = { rome_or_prettier("typescript") },
        yaml = { require("formatter.filetypes.yaml").prettierd },
        ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace,
            remove_trailing_newlines,
        },
    },
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function() vim.cmd([[FormatWrite]]) end,
    group = vim.api.nvim_create_augroup("autoformat", { clear = true }),
})

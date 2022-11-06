local util = require("formatter.util")
local sed = function(pattern, replacement, flags)
    return {
        exe = "sed",
        args = { util.quote_cmd_arg(util.wrap_sed_replace(pattern, replacement, flags)) },
        stdin = true,
    }
end
local remove_trailing_whitespace = util.withl(sed, "[ \t]*$")
local remove_trailing_newlines = { exe = "perl", args = { "-007", "-pe", [[s/\\n+$/\\n/gs]] }, stdin = true }

require("formatter").setup({
    filetype = {
        fish = { require("formatter.filetypes.fish").fishindent },
        javascript = { require("formatter.filetypes.javascript").prettierd },
        lua = { require("formatter.filetypes.lua").stylua },
        markdown = { require("formatter.filetypes.markdown").prettierd },
        ruby = {
            function()
                if require("utils").has_rubocop() then
                    return require("formatter.filetypes.ruby").rubocop()
                end

                return {
                    exe = "standardrb",
                    args = {
                        "--fix",
                        "--format",
                        "quiet",
                        "--stderr",
                        "--stdin",
                        util.escape_path(util.get_current_buffer_file_path()),
                    },
                    stdin = true,
                }
            end,
        },
        sh = { require("formatter.filetypes.sh").shfmt },
        typescript = { require("formatter.filetypes.typescript").prettierd },
        ["*"] = {
            remove_trailing_whitespace,
            remove_trailing_newlines,
        },
    },
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        vim.cmd([[FormatWrite]])
    end,
})

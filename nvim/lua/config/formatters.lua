local util = require("formatter.util")
local remove_trailing_newlines = {
    exe = "perl",
    args = { "-007", "-pe", [[s/\\n+$/\\n/gs]] },
    stdin = true,
}

local erb_lint = {
    exe = "erblint",
    args = { "--autocorrect", util.escape_path(util.get_current_buffer_file_path()) },
    stdin = false,
}

require("formatter").setup({
    filetype = {
        css = { require("formatter.filetypes.css").prettierd },
        eruby = { erb_lint },
        fish = { require("formatter.filetypes.fish").fishindent },
        html = { require("formatter.filetypes.html").prettierd },
        javascript = { require("formatter.filetypes.javascript").prettierd },
        lua = { require("formatter.filetypes.lua").stylua },
        markdown = { require("formatter.filetypes.markdown").prettierd },
        scss = { require("formatter.filetypes.css").prettierd },
        sh = { require("formatter.filetypes.sh").shfmt },
        typescript = { require("formatter.filetypes.typescript").prettierd },
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

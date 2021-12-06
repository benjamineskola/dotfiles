vim.cmd([[highlight IndentBlanklineIndent1 guibg=#282828 guifg=#282828 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guibg=#3c3836 guifg=#3c3836 gui=nocombine]])

require("indent_blankline").setup({
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
    space_char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
})

M = {
    "gelguy/wilder.nvim",
    event = "VeryLazy",
    build = ":UpdateRemotePlugins",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        { "romgrk/fzy-lua-native" },
    },
}

M.config = function()
    local wilder = require("wilder")

    wilder.setup({ modes = { ":", "/", "?" } })

    wilder.set_option(
        "renderer",
        wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
            border = "rounded",
            highlighter = wilder.lua_fzy_highlighter(),
            left = { " ", wilder.popupmenu_devicons() },
            right = { " ", wilder.popupmenu_scrollbar() },
        }))
    )

    wilder.set_option("pipeline", {
        wilder.branch(
            wilder.cmdline_pipeline({
                fuzzy = 1,
                fuzzy_filter = wilder.lua_fzy_filter(),
            }),
            wilder.vim_search_pipeline()
        ),
    })
end

return M

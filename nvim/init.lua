require("config.options")
require("config.lazy")

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require("config.commands")
        require("config.appearance")
        require("config.mappings")

        if vim.g.neovide then require("config.gui") end
    end,
})

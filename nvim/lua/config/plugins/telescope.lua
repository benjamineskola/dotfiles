local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    cmd = { "Telescope" },
}

M.config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
        defaults = {
            mappings = {
                i = {
                    ["<esc>"] = actions.close,
                    ["<C-h>"] = actions.which_key,
                },
            },
        },
    })

    require("telescope").load_extension("fzf")
end

return M

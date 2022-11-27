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

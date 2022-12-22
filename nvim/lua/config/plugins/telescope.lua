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

M.init = function()
    vim.keymap.set("n", "<leader>b", function() require("telescope.builtin").buffers() end, { noremap = true })
    vim.keymap.set("n", "<Leader>f", function() require("telescope.builtin").find_files() end, { noremap = true })
    vim.keymap.set("n", "<Leader>g", function() require("telescope.builtin").live_grep() end, { noremap = true })
    vim.keymap.set("n", "<Leader>o", function() require("telescope.builtin").oldfiles() end, { noremap = true })
    vim.keymap.set("n", "<leader>c", function() require("plugin.telescope-ext").projects() end, { noremap = true })
    vim.keymap.set("n", "<leader>y", function() require("plugin.telescope-ext").yaml_symbols() end, { noremap = true })
end

return M

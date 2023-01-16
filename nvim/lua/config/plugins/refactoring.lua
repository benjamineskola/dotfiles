local M = {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "plenary.nvim",
        "nvim-treesitter",
        "telescope.nvim",
    },
}

M.setup = true
M.init = function()
    require("telescope").load_extension("refactoring")
    vim.keymap.set(
        "v",
        "<leader>rr",
        function() require("telescope").extensions.refactoring.refactors() end,
        { noremap = true }
    )
end

return M

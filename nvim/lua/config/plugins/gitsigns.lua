local M = {
    "lewis6991/gitsigns.nvim",
    event = { "VeryLazy" },
    dependencies = { "nvim-lua/plenary.nvim" },
}

M.config = function()
    require("gitsigns").setup({
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
            local opts = { buffer = bufnr }

            -- Navigation
            vim.keymap.set("n", "]c", function()
                if vim.wo.diff then return "]c" end
                vim.schedule(function() gs.next_hunk() end)
                return "<Ignore>"
            end, { buffer = bufnr, expr = true })

            vim.keymap.set("n", "[c", function()
                if vim.wo.diff then return "[c" end
                vim.schedule(function() gs.prev_hunk() end)
                return "<Ignore>"
            end, { buffer = bufnr, expr = true })

            -- Actions
            vim.keymap.set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", opts)
            vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", opts)
            vim.keymap.set("n", "<leader>hS", gs.stage_buffer, opts)
            vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, opts)
            vim.keymap.set("n", "<leader>hR", gs.reset_buffer, opts)
            vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts)
            vim.keymap.set("n", "<leader>hb", function() gs.blame_line({ full = true }) end, opts)
            vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, opts)
            vim.keymap.set("n", "<leader>hd", gs.diffthis, opts)
            vim.keymap.set("n", "<leader>hD", function() gs.diffthis("~") end, opts)
            vim.keymap.set("n", "<leader>td", gs.toggle_deleted, opts)

            -- Text object
            vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", opts)
        end,
    })
end

return M

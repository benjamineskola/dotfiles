local M = {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
}

local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

function M.config()
    require("lualine").setup({
        sections = {
            lualine_b = {
                { "b:gitsigns_head", icon = "" },
                { "diff", source = diff_source },
            },
            lualine_x = {
                function()
                    if vim.bo.fileencoding and vim.bo.fileencoding ~= "utf-8" then return vim.bo.fileencoding end
                    return ""
                end,
                {
                    "fileformat",
                    symbols = {
                        unix = "",
                    },
                },
                "filetype",
            },
        },
        tabline = {
            lualine_a = {
                {
                    "buffers",
                    buffers_color = {
                        active = function() return { gui = vim.bo.modified and "italic" or "" } end,
                    },
                    inactive = function() return { gui = vim.bo.modified and "italic" or "" } end,
                },
            },
            lualine_z = {
                {
                    "tabs",
                    cond = function() return #vim.api.nvim_list_tabpages() > 1 end,
                },
            },
        },
    })
end

return M

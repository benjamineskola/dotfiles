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

require("lualine").setup({
    sections = {
        lualine_b = {
            { "b:gitsigns_head", icon = "" },
            { "diff", source = diff_source },
        },
        lualine_x = {
            function()
                if vim.bo.fileencoding and vim.bo.fileencoding ~= "utf-8" then
                    return vim.bo.fileencoding
                end
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
        lualine_a = { "buffers" },
        lualine_z = {
            {
                "tabs",
                cond = function()
                    return #vim.api.nvim_list_tabpages() > 1
                end,
            },
        },
    },
})

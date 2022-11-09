vim.opt.completeopt = "menu,menuone,noselect"
local cmp = require("cmp")

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    mapping = {
        ["<Esc>"] = cmp.mapping(function(fallback)
            -- if completion selected, cancel it;
            -- otherwise, close the completion window and fallback (i.e., leave insert mode)
            if cmp.visible() then
                if cmp.get_selected_entry() then
                    cmp.abort()
                else
                    cmp.abort()
                    fallback()
                end
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<CR>"] = cmp.mapping.confirm(),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            end
        end, { "i", "s" }),
    },
    sources = cmp.config.sources({ { name = "nvim_lsp" } }, { { name = "buffer" } }),
})

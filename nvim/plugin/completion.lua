vim.opt.completeopt = "menu,menuone,noselect"
local cmp = require("cmp")
local luasnip = require("luasnip")

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
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { "i", "s" }),
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = cmp.config.sources({
        { name = "luasnip" },
        { name = "nvim_lsp" },
    }, { { name = "buffer" } }),
})

require("luasnip.loaders.from_vscode").lazy_load()
luasnip.filetype_extend("ruby", { "rails" })

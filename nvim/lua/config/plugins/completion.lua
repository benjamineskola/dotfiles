local M = {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",

        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
    },
}

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

function M.config()
    vim.opt.completeopt = "menu,menuone,noselect"

    -- Setup nvim-cmp.
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
        mapping = {
            ["<C-e>"] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),
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
                elseif luasnip.expand_or_jumpable() then
                    luasnip.jump(-1)
                end
            end, { "i", "s" }),
        },
        snippet = {
            expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        sources = cmp.config.sources({
            { name = "luasnip" },
            { name = "nvim_lsp" },
        }, { { name = "buffer" } }),
    })

    require("luasnip.loaders.from_vscode").lazy_load()
    luasnip.filetype_extend("ruby", { "rails" })
end

return M

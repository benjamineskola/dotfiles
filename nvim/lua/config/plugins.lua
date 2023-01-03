return {
    { "anuvyklack/pretty-fold.nvim", config = true, event = { "BufReadPre", "BufNewFile" } },
    {
        "christoomey/vim-sort-motion",
        dependencies = {
            { "kana/vim-textobj-indent", dependencies = { "kana/vim-textobj-user" } },
        },
        config = function() vim.g.sort_motion_flags = "i" end,
        event = { "BufRead", "BufNewFile" },
    },
    {
        "code-biscuits/nvim-biscuits",
        config = { cursor_line_only = true },
        event = { "FileType" },
        dependencies = { "nvim-treesitter" },
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        config = function()
            require("tokyonight").setup({ style = "night" })
            vim.cmd.colorscheme("tokyonight")
        end,
    },
    {
        "gbprod/yanky.nvim",
        event = { "VeryLazy" },
        config = true,
        init = function()
            vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
            vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
            vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
            vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
            vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
            vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")
        end,
    },
    {
        "jose-elias-alvarez/typescript.nvim",
        ft = { "typescript" },
        config = true,
    },
    { "junegunn/goyo.vim", ft = { "markdown" } },
    {
        "janko/vim-test",
        config = function() vim.g["test#strategy"] = "neovim" end,
        cmd = { "TestNearest", "TestFile", "TestSuit", "TestLast", "TestVisit" },
    },
    { "Konfekt/FastFold", event = { "BufRead", "BufNewFile" } },
    {
        "kosayoda/nvim-lightbulb",
        config = function()
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                callback = require("nvim-lightbulb").update_lightbulb,
                group = vim.api.nvim_create_augroup("LightbulbUpdate", { clear = true }),
            })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = {
            space_char_blankline = " ",
            show_current_context = true,
            show_current_context_start = true,
        },
        event = { "BufRead", "BufNewFile" },
    },
    {
        "lukas-reineke/virt-column.nvim",
        config = { char = "│" },
        event = { "BufRead", "BufNewFile" },
    },
    { "moll/vim-bbye", event = { "BufRead", "BufNewFile" } },
    {
        "brenoprata10/nvim-highlight-colors",
        config = true,
        ft = { "css", "scss" },
    },
    {
        "nvim-tree/nvim-tree.lua",
        config = true,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = { "NvimTreeToggle" },
    },
    { "rizzatti/dash.vim", keys = { "<Plug>DashSearch" } },
    { "sheerun/vim-polyglot", event = { "VeryLazy" } },
    { "simnalamburt/vim-mundo", cmd = "MundoToggle" },
    { "simrat39/rust-tools.nvim", ft = { "rust", "toml" }, config = true },
    { "sjl/splice.vim", lazy = false },
    { "tpope/vim-commentary", event = { "VeryLazy" } },
    { "tpope/vim-dispatch", event = { "VeryLazy" } },
    { "tpope/vim-eunuch", event = { "VeryLazy" } },
    { "tpope/vim-fugitive", dependencies = { "tpope/vim-rhubarb" }, event = { "VeryLazy" } },
    { "tpope/vim-projectionist", event = { "VeryLazy" } },
    { "tpope/vim-ragtag", config = function() vim.g.ragtag_global_maps = true end, event = { "VeryLazy" } },
    { "tpope/vim-rails", ft = { "ruby", "eruby" } },
    { "tpope/vim-repeat", event = { "VeryLazy" } },
    { "tpope/vim-sensible", event = { "VeryLazy" } },
    { "tpope/vim-surround", event = { "VeryLazy" } },
    { "tpope/vim-unimpaired", event = { "VeryLazy" } },
    { "williamboman/mason.nvim" },
    {
        "windwp/nvim-autopairs",
        config = {
            check_ts = true,
            enable_afterquote = false,
        },
    },
}

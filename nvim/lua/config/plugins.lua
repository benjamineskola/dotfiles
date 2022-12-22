return {
    {
        "christoomey/vim-sort-motion",
        dependencies = { "kana/vim-textobj-indent" },
        config = function() vim.g.sort_motion_flags = "i" end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        config = function() require("tokyonight").setup() end,
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("trouble").setup({ auto_open = true, auto_close = true })
            require("trouble-autoopen")
        end,
        cmd = { "TroubleToggle", "Trouble" },
    },
    {
        "jose-elias-alvarez/typescript.nvim",
        ft = { "typescript" },
        config = function() require("typescript").setup({}) end,
    },
    { "junegunn/goyo.vim", ft = { "markdown" } },
    {
        "janko/vim-test",
        config = function() vim.g["test#strategy"] = "neovim" end,
        cmd = { "TestNearest", "TestFile", "TestSuit", "TestLast", "TestVisit" },
    },
    { "Konfekt/FastFold" },
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
        config = function()
            require("indent_blankline").setup({
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,
            })
        end,
    },
    {
        "lukas-reineke/virt-column.nvim",
        config = function() require("virt-column").setup() end,
    },
    { "moll/vim-bbye", event = { "BufReadPost" } },
    {
        "brenoprata10/nvim-highlight-colors",
        config = function() require("nvim-highlight-colors").setup({}) end,
        ft = { "css", "scss" },
    },
    {
        "nvim-tree/nvim-tree.lua",
        config = function() require("nvim-tree").setup() end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = { "NvimTreeToggle" },
    },
    { "rizzatti/dash.vim" },
    { "sheerun/vim-polyglot" },
    { "simnalamburt/vim-mundo", cmd = "MundoToggle" },
    { "simrat39/rust-tools.nvim", ft = { "rust", "toml" }, config = function() require("rust-tools").setup() end },
    { "tpope/vim-commentary", event = { "VeryLazy" } },
    { "tpope/vim-dispatch", event = { "VeryLazy" } },
    { "tpope/vim-eunuch", event = { "VeryLazy" } },
    { "tpope/vim-fugitive", dependencies = { "tpope/vim-rhubarb" }, event = { "VeryLazy" } },
    { "tpope/vim-projectionist", event = { "VeryLazy" } },
    { "tpope/vim-ragtag", config = function() vim.g.ragtag_global_maps = true end, event = { "VeryLazy" } },
    { "tpope/vim-rails", event = { "VeryLazy" } },
    { "tpope/vim-repeat", event = { "VeryLazy" } },
    { "tpope/vim-sensible", event = { "VeryLazy" } },
    { "tpope/vim-surround", event = { "VeryLazy" } },
    { "tpope/vim-unimpaired", event = { "VeryLazy" } },
    { "williamboman/mason.nvim" },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true,
                enable_afterquote = false,
            })
        end,
    },
}

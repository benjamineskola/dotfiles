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
        opts = { cursor_line_only = true },
        event = { "FileType" },
        dependencies = { "nvim-treesitter" },
    },
    {
        "cuducos/yaml.nvim",
        ft = { "yaml" }, -- optional
        dependencies = {
            "nvim-treesitter",
            "telescope.nvim",
        },
        config = function() vim.keymap.set({ "n" }, "<leader>y", require("yaml_nvim").telescope, { remap = false }) end,
    },
    {
        "folke/which-key.nvim",
        event = { "VeryLazy" },
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup()
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
        "loctvl842/monokai-pro.nvim",
        lazy = false,
        config = function()
            require("monokai-pro").setup({ filter = "spectrum" })
            vim.cmd([[colorscheme monokai-pro]])
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            space_char_blankline = " ",
            show_current_context = true,
            show_current_context_start = true,
        },
        event = { "BufRead", "BufNewFile" },
    },
    {
        "lukas-reineke/virt-column.nvim",
        opts = { char = "│" },
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
    { "tpope/vim-commentary", event = { "VeryLazy" } },
    { "tpope/vim-dispatch", event = { "VeryLazy" } },
    { "tpope/vim-eunuch", event = { "VeryLazy" } },
    { "tpope/vim-fugitive", dependencies = { "tpope/vim-rhubarb" }, event = { "VeryLazy" }, cmd = { "Gvdiffsplit" } },
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
        opts = {
            check_ts = true,
            enable_afterquote = false,
        },
    },
}

local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = nil
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ "mkdir", "-p", install_path .. "/.." })
    packer_bootstrap = vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim") -- include so that clean does not remove it

    use({
        "christoomey/vim-sort-motion",
        requires = { "kana/vim-textobj-user", "kana/vim-textobj-indent" },
        config = function()
            vim.g.sort_motion_flags = "i"
        end,
    })
    use({
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup()
        end,
    })
    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup({ auto_open = true, auto_close = true })
            require("trouble-autoopen")
        end,
    })
    use({
        "gelguy/wilder.nvim",
        requires = { "nvim-tree/nvim-web-devicons", "romgrk/fzy-lua-native" },
    })
    use({
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
    })
    use({
        "janko/vim-test",
        config = function()
            vim.g["test#strategy"] = "neovim"
        end,
    })
    use({ "Konfekt/FastFold" })
    use({
        "kosayoda/nvim-lightbulb",
        config = function()
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                callback = require("nvim-lightbulb").update_lightbulb,
                group = vim.api.nvim_create_augroup("LightbulbUpdate", { clear = true }),
            })
        end,
    })
    use({
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("gitsigns").setup()
        end,
    })
    use({ "lukas-reineke/indent-blankline.nvim" })
    use({
        "lukas-reineke/virt-column.nvim",
        config = function()
            require("virt-column").setup()
        end,
    })
    use({ "mfussenegger/nvim-lint", rocks = { "luacheck" } })
    use({ "benjamineskola/formatter.nvim" })
    use({ "moll/vim-bbye" })
    use({ "neovim/nvim-lspconfig" })
    use({
        "nvim-lualine/lualine.nvim",
        requires = { { "kyazdani42/nvim-web-devicons", opt = true } },
    })
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        },
    })
    use({
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup()
        end,
        requires = { "nvim-tree/nvim-web-devicons" },
    })
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use({ "nvim-treesitter/nvim-treesitter-refactor" })
    use({ "nvim-treesitter/nvim-treesitter-textobjects" })
    use({ "RRethy/nvim-treesitter-endwise" })
    use({ "rizzatti/dash.vim" })
    use({ "sheerun/vim-polyglot" })
    use({ "simnalamburt/vim-mundo" })
    use({ "tpope/vim-commentary" })
    use({ "tpope/vim-dispatch" })
    use({ "tpope/vim-eunuch" })
    use({ "tpope/vim-fugitive", requires = { "tpope/vim-rhubarb" } })
    use({ "tpope/vim-projectionist" })
    use({ "tpope/vim-ragtag", config = "vim.g.ragtag_global_maps = true" })
    use({ "tpope/vim-rails" })
    use({ "tpope/vim-repeat" })
    use({ "tpope/vim-sensible" })
    use({ "tpope/vim-surround" })
    use({ "tpope/vim-unimpaired" })
    use({ "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" })
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true,
                enable_afterquote = false,
            })
        end,
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        pattern = { "plugins.lua" },
        callback = function()
            vim.cmd([[source <afile> | PackerCompile]])
        end,
        group = vim.api.nvim_create_augroup("packer_user_config", { clear = true }),
    })
end)

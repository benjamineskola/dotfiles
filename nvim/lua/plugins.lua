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

    use({ "andrewferrier/vim-wrapping-softhard" })
    use({ "antoinemadec/FixCursorHold.nvim" })
    use({ "benjamineskola/vim-applescript" })
    use({ "christoomey/vim-sort-motion", requires = { "kana/vim-textobj-user", "kana/vim-textobj-indent" } })
    use({ "davidhalter/jedi-vim" })
    use({
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
    })
    use({ "janko/vim-test" })
    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        rocks = { "luacheck" },
    })
    use({ "Konfekt/FastFold" })
    use({
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("gitsigns").setup()
        end,
    })
    use({ "lukas-reineke/indent-blankline.nvim" })
    use({ "moll/vim-bbye" })
    use({ "morhetz/gruvbox" })
    use({ "neovim/nvim-lspconfig", "williamboman/nvim-lsp-installer" })
    use({
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", run = "make" } },
    })
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use({ "nvim-treesitter/nvim-treesitter-refactor" })
    use({ "nvim-treesitter/nvim-treesitter-textobjects" })
    use({ "rizzatti/dash.vim" })
    use({ "sheerun/vim-polyglot" })
    use({ "simnalamburt/vim-mundo" })
    use({ "sjl/splice.vim" })
    use({ "tmhedberg/SimpylFold" })
    use({ "tpope/vim-commentary" })
    use({ "tpope/vim-dispatch" })
    use({ "tpope/vim-eunuch" })
    use({ "tpope/vim-fugitive" })
    use({ "tpope/vim-projectionist" })
    use({ "tpope/vim-repeat" })
    use({ "tpope/vim-sensible" })
    use({ "tpope/vim-surround" })
    use({ "tpope/vim-unimpaired" })
    use({ "vim-airline/vim-airline" })
    use({
        "windwp/nvim-autopairs",
        config = function()
            local npairs = require("nvim-autopairs")
            npairs.setup({ check_ts = true, enable_afterquote = false })
            npairs.add_rules(require("nvim-autopairs.rules.endwise-elixir"))
            npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))
            npairs.add_rules(require("nvim-autopairs.rules.endwise-ruby"))
        end,
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end

    vim.cmd([[
    augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
  ]])
end)

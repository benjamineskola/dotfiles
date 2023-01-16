local M = {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost" },
    run = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-refactor",
        "nvim-treesitter/nvim-treesitter-textobjects",
        "RRethy/nvim-treesitter-endwise",
    },
}

M.config = function()
    require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        ignore_install = { "phpdoc" },
        endwise = { enable = true },
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
        refactor = {
            highlight_definitions = { enable = true },
            -- highlight_current_scope = { enable = true },
            smart_rename = {
                enable = true,
                keymaps = {
                    smart_rename = "<leader>rn",
                },
            },
            navigation = {
                enable = true,
                keymaps = {
                    goto_definition_lsp_fallback = "gnd",
                    list_definitions = "gnD",
                    list_definitions_toc = "gO",
                    goto_next_usage = "*",
                    goto_previous_usage = "#",
                },
            },
        },
        textobjects = {
            select = {
                enable = true,

                -- Automatically jump forward to textobj, similar to targets.vim
                -- lookahead = true,

                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["ab"] = "@block.outer",
                    ["ib"] = "@block.inner",
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]m"] = "@function.outer",
                    ["]]"] = "@class.outer",
                },
                goto_next_end = {
                    ["]M"] = "@function.outer",
                    ["]["] = "@class.outer",
                },
                goto_previous_start = {
                    ["[m"] = "@function.outer",
                    ["[["] = "@class.outer",
                },
                goto_previous_end = {
                    ["[M"] = "@function.outer",
                    ["[]"] = "@class.outer",
                },
            },
        },
    })

    local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
    ft_to_parser["eruby.yaml"] = "yaml"
end

return M

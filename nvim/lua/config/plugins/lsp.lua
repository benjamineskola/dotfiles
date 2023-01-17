local M = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost" },
}

M.config = function()
    local lspconfig = require("lspconfig")

    local default_on_attach = function(client)
        if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_autocmd({ "BufWritePre" }, {
                callback = function(opts) vim.lsp.buf.format({ bufnr = opts.buf }) end,
                group = vim.api.nvim_create_augroup("FormatSync", { clear = true }),
            })
        end
    end

    local lsp_servers = {
        bashls = { package_name = "bash-language-server" },
        cssls = { package_name = "css-lsp" },
        eslint = { package_name = "eslint-lsp" },
        golangci_lint_ls = { package_name = "golangci-lint-langserver" },
        gopls = {
            settings = { gopls = { gofumpt = true } },
        },
        -- hls = {
        --     package_name = "haskell-language-server",
        --     settings = { haskell = { formattingProvider = "brittany" } },
        -- },
        jsonls = { package_name = "json-lsp" },
        pylsp = {
            package_name = "python-lsp-server",
            settings = {
                pylsp = {
                    plugins = {
                        autopep8 = { enabled = false },
                        black = { enabled = true },
                        ruff = { enabled = true },
                        yapf = { enabled = false },
                    },
                },
            },
        },
        rome = {
            root_dir = function(fname)
                local util = require("lspconfig.util")

                local root = util.find_package_json_ancestor(fname)
                    or util.find_node_modules_ancestor(fname)
                    or util.find_git_ancestor(fname)

                if root and util.is_file(root .. "/rome.json") then
                    return root
                else
                    return vim.env.XDG_CONFIG_HOME
                end
            end,
        },
        rust_analyzer = { setup = false },
        solargraph = {},
        sumneko_lua = {
            package_name = "lua-language-server",
            settings = {
                Lua = {
                    format = { enable = false },
                },
            },
        },
        tsserver = { package_name = "typescript-language-server", setup = false },
        vimls = { package_name = "vim-language-server" },
        yamlls = { package_name = "yaml-language-server" },
    }

    for server, config in pairs(lsp_servers) do
        if config.on_attach == nil then config.on_attach = default_on_attach end

        if config.package_name == nil then config.package_name = server:gsub("_", "-") end

        if config.setup == nil or config.setup ~= false then lspconfig[server].setup(config) end
    end

    local function install_commands()
        local registry = require("mason-registry")

        for server, config in pairs(lsp_servers) do
            if config.package_name == nil then config.package_name = server end

            local package = registry.get_package(config.package_name)
            if not package:is_installed() then package:install() end
        end
    end

    vim.api.nvim_create_autocmd({ "BufReadPost" }, {
        callback = install_commands,
        group = vim.api.nvim_create_augroup("MasonInstall", { clear = true }),
    })

    vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. ":" .. vim.env.PATH

    vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(params)
            local opts = { noremap = true, buffer = params.buf }

            -- Displays hover information about the symbol under the cursor
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

            -- Jump to the definition
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

            -- Jump to declaration
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

            -- Lists all the implementations for the symbol under the cursor
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

            -- Jumps to the definition of the type symbol
            vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)

            -- Lists all the references
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

            -- Displays a function's signature information
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

            -- Renames all references to the symbol under the cursor
            vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)

            -- Selects a code action available at the current cursor position
            vim.keymap.set({ "n", "v" }, "<Leader>x", vim.lsp.buf.code_action, opts)

            -- Show diagnostics in a floating window
            vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)

            -- Move to the previous diagnostic
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

            -- Move to the next diagnostic
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        end,
    })
end

return M

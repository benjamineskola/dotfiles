local M = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost" },
}

local function want_rubocop(client)
    local util = require("lspconfig.util")
    local root = client.workspace_folders[1].name

    return root and util.path.is_file(root .. "/.rubocop.yml")
end

M.default_on_attach = function(client)
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            callback = function(opts) vim.lsp.buf.format({ bufnr = opts.buf, name = client.name }) end,
            group = vim.api.nvim_create_augroup("autoformat_" .. client.name, { clear = true }),
        })
    end
end

M.config = function()
    local lspconfig = require("lspconfig")
    local util = require("lspconfig.util")

    local ruby_on_attach = function(client)
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            callback = function(opts)
                vim.lsp.buf.format({ bufnr = opts.buf, name = "standardrb" })
                if want_rubocop(client) then vim.lsp.buf.format({ bufnr = opts.buf, name = "solargraph" }) end
            end,
            group = vim.api.nvim_create_augroup("autoformat_ruby", { clear = true }),
        })
    end

    local lsp_servers = {
        ansiblels = {},
        bashls = {},
        cssls = {},
        dockerls = {},
        golangci_lint_ls = {},
        gopls = {
            settings = { gopls = { gofumpt = true } },
        },
        hls = { settings = { haskell = { formattingProvider = "brittany" } } },
        jsonls = {},
        ltex = { settings = { ltex = { language = "en-gb" } } },
        marksman = {},
        pylsp = {
            settings = {
                pylsp = {
                    plugins = {
                        autopep8 = { enabled = false },
                        black = { enabled = true },
                        yapf = { enabled = false },
                        pycodestyle = { enabled = false },
                        pydocstyle = { enabled = false },
                        ruff = { enabled = false },
                    },
                },
            },
        },
        rome = {
            root_dir = function(fname)
                local root = util.find_package_json_ancestor(fname)
                    or util.find_node_modules_ancestor(fname)
                    or util.find_git_ancestor(fname)

                if root and util.path.is_file(root .. "/rome.json") then
                    return root
                else
                    return vim.env.XDG_CONFIG_HOME
                end
            end,
        },
        ruff_lsp = {},
        rust_analyzer = { setup = false },
        solargraph = { on_attach = ruby_on_attach },
        standardrb = { on_attach = ruby_on_attach },
        lua_ls = {
            cmd = {
                "lua-language-server",
                "--logpath",
                vim.env.XDG_CACHE_HOME .. "/lua_ls/logs",
                "--metapath",
                vim.env.XDG_CACHE_HOME .. "/lua_ls/meta",
            },
            settings = {
                Lua = {
                    format = {
                        defaultConfig = { align_continuous_rect_table_field = "false", align_array_table = "false" },
                    },
                },
            },
        },
        taplo = {},
        terraformls = {},
        tflint = {},
        tsserver = { setup = false },
        vimls = {},
        yamlls = {},
    }

    for server, config in pairs(lsp_servers) do
        if config.on_attach == nil then config.on_attach = M.default_on_attach end

        if config.setup == nil or config.setup ~= false then lspconfig[server].setup(config) end
    end

    vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(params)
            local opts = { noremap = true, buffer = params.buf }

            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- Display hover information
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- Jump to the definition
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- Jump to declaration
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts) -- List all implementations
            vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts) -- Jump to definition of type symbol
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) -- List all references
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts) -- Display function signature information
            vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts) -- Rename all references
            vim.keymap.set({ "n", "v" }, "<Leader>x", vim.lsp.buf.code_action, opts) -- Select code action
            vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts) -- Show diagnostics
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- Move to previous diagnostic
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- Move to next diagnostic
        end,
    })
end

return M

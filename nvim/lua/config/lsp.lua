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
                    flake8 = { enabled = true },
                    mccabe = { enabled = false },
                    pycodestyle = { enabled = false },
                    pydocstyle = { enabled = false },
                    pyflakes = { enabled = false },
                    yapf = { enabled = false },
                },
            },
        },
    },
    rome = {
        on_attach = function() end, -- don't trust lsp to format
    },
    rust_analyzer = { setup = false },
    ruby_ls = {
        package_name = "ruby-lsp",
        on_attach = function(client, bufnr)
            default_on_attach(client)

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre", "CursorHold" }, {
                buffer = bufnr,

                callback = function()
                    local params = vim.lsp.util.make_text_document_params(bufnr)

                    client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
                        if err then return end

                        vim.lsp.diagnostic.on_publish_diagnostics(
                            nil,
                            vim.tbl_extend("keep", params, { diagnostics = result.items }),
                            { client_id = client.id }
                        )
                    end)
                end,
            })
        end,
    },
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
        vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, opts)

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

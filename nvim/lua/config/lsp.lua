local lspconfig = require("lspconfig")

local default_on_attach = function(client)
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            callback = function(opts)
                vim.lsp.buf.format({ bufnr = opts.buf })
            end,
            group = vim.api.nvim_create_augroup("FormatSync", { clear = true }),
        })
    end
end

lsp_servers = {
    bashls = {},
    cssls = {},
    eslint = {},
    gopls = {
        settings = { gopls = { gofumpt = true } },
    },
    hls = {
        settings = { haskell = { formattingProvider = "brittany" } },
    },
    jsonls = {},
    pylsp = {
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
    rust_analyzer = {},
    solargraph = {},
    sumneko_lua = {
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "jit", "vim" }, disable = { "lowercase-global" } },
                workspace = { ignoreDir = { "packer_compiled.lua" } },
                format = { enable = false },
            },
        },
    },
    vimls = {},
    yamlls = {},
}

for server, config in pairs(lsp_servers) do
    if config.on_attach == nil then
        config.on_attach = default_on_attach
    end

    lspconfig[server].setup(config)
end

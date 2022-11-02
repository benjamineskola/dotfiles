local lspconfig = require("lspconfig")

local default_on_attach = function(client)
    if client.server_capabilities.documentFormattingProvider then
        vim.cmd([[augroup FormatSync
                  autocmd!
                  autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
                  augroup END
        ]])
    end
end

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "bashls",
        "cssls",
        "eslint",
        "gopls",
        "hls",
        "jsonls",
        "sumneko_lua",
        "pylsp",
        "solargraph",
        "vimls",
        "yamlls",
    },
    automatic_installation = true,
})

require("mason-lspconfig").setup_handlers({
    function(server_name) -- default handler (optional)
        lspconfig[server_name].setup({ on_attach = default_on_attach })
    end,
    ["gopls"] = function()
        lspconfig.gopls.setup({
            on_attach = default_on_attach,
            settings = {
                gopls = {
                    gofumpt = true,
                },
            },
        })
    end,
    ["hls"] = function()
        lspconfig.hls.setup({
            on_attach = default_on_attach,
            settings = {
                haskell = {
                    formattingProvider = "brittany",
                },
            },
        })
    end,
    ["pylsp"] = function()
        lspconfig.pylsp.setup({
            on_attach = default_on_attach,
            settings = {
                pylsp = {
                    plugins = {
                        autopep8 = { enabled = false },
                        flake8 = {
                            enabled = true,
                            executable = "flake518",
                        },
                        mccabe = { enabled = false },
                        pycodestyle = { enabled = false },
                        pydocstyle = { enabled = false },
                        pyflakes = { enabled = false },
                        pylint = { enabled = true },
                        yapf = { enabled = false },
                    },
                },
            },
        })
    end,
    ["sumneko_lua"] = function()
        lspconfig.sumneko_lua.setup({
            on_attach = default_on_attach,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "jit", "vim" },
                        disable = { "lowercase-global" },
                    },
                },
            },
        })
    end,
})

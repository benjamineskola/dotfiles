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

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "bashls",
        "cssls",
        "eslint",
        "gopls",
        "jsonls",
        "sumneko_lua",
        "pylsp",
        "rust_analyzer",
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
                        black = { enabled = true },
                        flake8 = {
                            enabled = true,
                        },
                        mccabe = { enabled = false },
                        pycodestyle = { enabled = false },
                        pydocstyle = { enabled = false },
                        pyflakes = { enabled = false },
                        yapf = { enabled = false },
                    },
                },
            },
        })
        local pylsp_dir = require("mason-registry").get_package("python-lsp-server"):get_install_path()
        os.execute(
            "cd "
                .. vim.fn.shellescape(pylsp_dir, true)
                .. "&& . venv/bin/activate && "
                .. "pip install -U -qqq --disable-pip-version-check python-lsp-black pyls-isort pylsp-mypy"
        )
    end,
    ["sumneko_lua"] = function()
        lspconfig.sumneko_lua.setup({
            on_attach = default_on_attach,
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        globals = { "jit", "vim" },
                        disable = { "lowercase-global" },
                    },
                    workspace = {
                        ignoreDir = { "packer_compiled.lua" },
                    },
                    format = {
                        enable = false,
                    },
                },
            },
        })
    end,
})

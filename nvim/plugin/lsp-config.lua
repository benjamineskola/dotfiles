local lsp_installer = require("nvim-lsp-installer")

-- Include the servers you want to have installed by default below
local servers = {
    "bashls",
    "cssls",
    "eslint",
    "gopls",
    "hls",
    "jsonls",
    "pylsp",
    "solargraph",
    "sumneko_lua",
    "vimls",
    "yamlls",
}

local default_opts = {
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd([[augroup FormatSync
                  autocmd!
                  autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
                  augroup END
        ]])
        end
    end,
}
local server_opts = {
    ["sumneko_lua"] = function()
        default_opts.settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                    disable = { "lowercase-global" },
                },
            },
        }
    end,
}

for _, name in pairs(servers) do
    local server_available, requested_server = lsp_installer.get_server(name)
    if server_available then
        requested_server:on_ready(function()
            local opts = server_opts[name] and server_opts[name]() or default_opts
            requested_server:setup(opts)
        end)
        if not requested_server:is_installed() then
            print("Installing " .. name)
            requested_server:install()

            -- if name == "pylsp" then
            --     vim.cmd([[PylspInstall pyls-flake8 pylsp-mypy pyls-isort python-lsp-black]])
            -- end
        end
    end
end

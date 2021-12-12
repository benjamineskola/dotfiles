local lsp_installer = require("nvim-lsp-installer")

-- Include the servers you want to have installed by default below
local servers = {
    bashls = {},
    cssls = {},
    eslint = {},
    gopls = {
        gopls = {
            gofumpt = true,
        },
    },
    hls = {
        haskell = {
            formattingProvider = "brittany",
        },
    },
    jsonls = {},
    pylsp = {
        pylsp = {
            plugins = {
                flake8 = { enabled = true, executable = "flake518", },
                pycodestyle = { enabled = false },
                pydocstyle = { enabled = false },
                mccabe = { enabled = false },
            },
        },
    },
    solargraph = {},
    sumneko_lua = {
        Lua = {
            diagnostics = {
                globals = { "jit", "vim" },
                disable = { "lowercase-global" },
            },
        },
    },
    vimls = {},
    yamlls = {},
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

for name, settings in pairs(servers) do
    local server_available, requested_server = lsp_installer.get_server(name)
    if server_available then
        requested_server:on_ready(function()
            local opts = default_opts
            opts.settings = settings
            requested_server:setup(opts)
        end)

        if not requested_server:is_installed() then
            print("Installing " .. name)
            requested_server:install()
        end
    end
end

vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath("data") .. "/lsp_servers/haskell"

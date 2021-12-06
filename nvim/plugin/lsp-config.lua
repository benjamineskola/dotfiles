local lsp_installer = require("nvim-lsp-installer")

-- Include the servers you want to have installed by default below
local servers = {
    "bashls",
    "cssls",
    "eslint",
    "gopls",
    "hls",
    "jedi_language_server",
    "jsonls",
    "solargraph",
    "sumneko_lua",
    "vimls",
    "yamlls",
}

for _, name in pairs(servers) do
    local server_available, requested_server = lsp_installer.get_server(name)
    if server_available then
        requested_server:on_ready(function()
            local opts = {}
            requested_server:setup(opts)
        end)
        if not requested_server:is_installed() then
            print("Installing " .. name)
            requested_server:install()
        end
    end
end

require("config.plugins")

require("config.options")
require("config.commands")
require("config.appearance")

if vim.g.neovide then
    require("config.gui")
end

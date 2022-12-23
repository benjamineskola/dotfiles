require("config.options")
require("config.appearance")
require("config.mappings")
require("config.lazy")
require("config.commands")

if vim.g.neovide then require("config.gui") end

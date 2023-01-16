local M = {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "TroubleToggle", "Trouble" },
}

local state

local function disableAutoOpenClose()
    local troubleOpts = require("trouble.config").options
    state = {
        auto_open = troubleOpts.auto_open,
        auto_close = troubleOpts.auto_close,
    }
    troubleOpts.auto_open = false
    troubleOpts.auto_close = false
end

local function restoreAutoOpenClose()
    if state == nil then return end
    local troubleOpts = require("trouble.config").options
    troubleOpts.auto_open = state.auto_open
    troubleOpts.auto_close = state.auto_close
    state = nil
    require("trouble").refresh({ auto = true, provider = "diagnostics" })
end

M.config = function()
    require("trouble").setup({ auto_open = true, auto_close = true })

    local augroup = vim.api.nvim_create_augroup("user_trouble", { clear = true })
    vim.api.nvim_create_autocmd({ "InsertEnter" }, {
        callback = disableAutoOpenClose,
        group = augroup,
    })
    vim.api.nvim_create_autocmd({ "InsertLeave" }, {
        callback = restoreAutoOpenClose,
        group = augroup,
    })
end

return M

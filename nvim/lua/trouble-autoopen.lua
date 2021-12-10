local M = {}
local state

function M.disableAutoOpenClose()
    local troubleOpts = require("trouble.config").options
    state = {
        auto_open = troubleOpts.auto_open,
        auto_close = troubleOpts.auto_close,
    }
    troubleOpts.auto_open = false
    troubleOpts.auto_close = false
end

function M.restoreAutoOpenClose()
    if state == nil then
        return
    end
    local troubleOpts = require("trouble.config").options
    troubleOpts.auto_open = state.auto_open
    troubleOpts.auto_close = state.auto_close
    state = nil
    require("trouble").refresh({ auto = true, provider = "diagnostics" })
end

vim.cmd([[
  augroup user_trouble
    autocmd!
    autocmd InsertEnter * lua require('trouble-autoopen').disableAutoOpenClose()
    autocmd InsertLeave * lua require('trouble-autoopen').restoreAutoOpenClose()
  augroup END
]])

return M

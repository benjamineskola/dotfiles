local M = {}

local actions = require("telescope.actions")

M.projects = function()
    local opts = {
        find_command = {
            "zoxide",
            "query",
            "-l",
        },
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local path = require("telescope.actions.state").get_selected_entry(prompt_bufnr).value
                vim.cmd.cd(path)
            end)
            return true
        end,
    }
    require("telescope.builtin").find_files(opts)
end

return M

local M = {}

local actions = require("telescope.actions")

M.projects = function()
    local opts = {
        find_command = {
            "sh",
            "-c",
            "(zoxide query -l; fd -E Library -E .Trash --type d -H '^\\.(git|hg)$' $HOME -x dirname; echo $HOME) | perl -ne 'print unless $seen{$_}++'",
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

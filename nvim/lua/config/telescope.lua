local actions = require("telescope.actions")
require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<C-h>"] = actions.which_key,
            },
        },
    },
    pickers = {
        find_files = {
            mappings = {
                i = {
                    ["<CR>"] = function(prompt_bufnr)
                        local path = require("telescope.actions.state").get_selected_entry(prompt_bufnr).value
                        local f = io.open(path, "r")
                        if f == nil then return end
                        local _, _, code = f:read(1)
                        f:close()
                        if code == 21 then -- EISDIR
                            actions.close(prompt_bufnr)
                            vim.fn.execute("cd " .. path, "silent")
                        else
                            actions.select_default(prompt_bufnr)
                        end
                    end,
                },
            },
        },
    },
})

require("telescope").load_extension("fzf")
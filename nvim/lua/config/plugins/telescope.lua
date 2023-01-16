local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    cmd = { "Telescope" },
}

M.config = function()
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
    })

    require("telescope").load_extension("fzf")
end

local function project_files(opts)
    opts = opts or {}
    opts.show_untracked = true
    if vim.loop.fs_stat(".git") then
        require("telescope.builtin").git_files(opts)
    else
        local client = vim.lsp.get_active_clients()[1]
        if client then opts.cwd = client.config.root_dir end
        require("telescope.builtin").find_files(opts)
    end
end

local function projects()
    local actions = require("telescope.actions")

    local opts = {
        find_command = {
            "sh",
            "-c",
            [[(zoxide query -l;
              fd -E Library -E .Trash --type d -H '^\\.(git|hg)$' $HOME -x dirname;
              echo $HOME) | perl -ne 'print unless $seen{$_}++']],
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

M.init = function()
    vim.keymap.set("n", "<leader>b", function() require("telescope.builtin").buffers() end, { noremap = true })
    vim.keymap.set("n", "<Leader>f", project_files, { noremap = true })
    vim.keymap.set("n", "<Leader>g", function() require("telescope.builtin").live_grep() end, { noremap = true })
    vim.keymap.set("n", "<Leader>o", function() require("telescope.builtin").oldfiles() end, { noremap = true })
    vim.keymap.set("n", "<leader>c", projects, { noremap = true })
end

return M

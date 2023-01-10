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

M.init = function()
    vim.keymap.set("n", "<leader>b", function() require("telescope.builtin").buffers() end, { noremap = true })
    vim.keymap.set("n", "<Leader>f", M.project_files, { noremap = true })
    vim.keymap.set("n", "<Leader>g", function() require("telescope.builtin").live_grep() end, { noremap = true })
    vim.keymap.set("n", "<Leader>o", function() require("telescope.builtin").oldfiles() end, { noremap = true })
    vim.keymap.set("n", "<leader>c", M.projects, { noremap = true })
    vim.keymap.set("n", "<leader>y", M.yaml_symbols, { noremap = true })
end

function M.project_files(opts)
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

M.projects = function()
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

local function visit_yaml_node(node, yaml_path, result, file_path, bufnr)
    local key = ""
    if node:type() == "block_mapping_pair" then
        local field_key = node:field("key")[1]
        key = vim.treesitter.query.get_node_text(field_key, bufnr)
    end

    if key ~= nil and string.len(key) > 0 then
        table.insert(yaml_path, key)
        local line, col = node:start()
        table.insert(result, {
            lnum = line + 1,
            col = col + 1,
            bufnr = bufnr,
            filename = file_path,
            text = table.concat(yaml_path, "."),
        })
    end

    for child_node, _ in node:iter_children() do
        visit_yaml_node(child_node, yaml_path, result, file_path, bufnr)
    end

    if key ~= nil and string.len(key) > 0 then table.remove(yaml_path, table.maxn(yaml_path)) end
end

local function gen_from_yaml_nodes(opts)
    local make_entry = require("telescope.make_entry")
    local pickers = require("telescope.pickers")

    local displayer = pickers.entry_display.create({
        separator = " │ ",
        items = {
            { width = 5 },
            { remaining = true },
        },
    })

    local make_display = function(entry)
        return displayer({
            { entry.lnum, "TelescopeResultsSpecialComment" },
            { entry.text, function() return {} end },
        })
    end

    return function(entry)
        return make_entry.set_default_entry_mt({
            ordinal = entry.text,
            display = make_display,
            filename = entry.filename,
            lnum = entry.lnum,
            text = entry.text,
            col = entry.col,
        }, opts)
    end
end

M.yaml_symbols = function(opts)
    local conf = require("telescope.config").values
    local finders = require("telescope.finders")
    local pickers = require("telescope.pickers")

    if not opts then opts = {} end

    local yaml_path = {}
    local result = {}
    local bufnr = vim.api.nvim_get_current_buf()
    local tree = vim.treesitter.get_parser(bufnr, "yaml"):parse()[1]
    local file_path = vim.api.nvim_buf_get_name(bufnr)
    local root = tree:root()
    for node, _ in root:iter_children() do
        visit_yaml_node(node, yaml_path, result, file_path, bufnr)
    end

    -- return result
    pickers
        .new(opts, {
            prompt_title = "YAML symbols",
            finder = finders.new_table({
                results = result,
                entry_maker = opts.entry_maker or gen_from_yaml_nodes(opts),
            }),
            sorter = conf.generic_sorter(opts),
            previewer = conf.grep_previewer(opts),
        })
        :find()
end

return M

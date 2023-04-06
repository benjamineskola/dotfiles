vim.filetype.add({
    pattern = {
        [".*/ansible/.*.ya?ml"] = { "yaml.ansible", { priority = 10 } },
    },
})

local function set_ft_opts(ft, cmd) vim.api.nvim_create_autocmd({ "FileType" }, { pattern = ft, command = cmd }) end
set_ft_opts({ "fish", "lua", "python", "rust", "sh" }, "set sw=4")
set_ft_opts({ "go", "just", "make" }, "set sw=0 ts=4 noexpandtab")

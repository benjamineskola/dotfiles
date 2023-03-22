vim.filetype.add({
    pattern = {
        [".*/ansible/.*.ya?ml"] = { "yaml.ansible", { priority = 10 } },
    },
})

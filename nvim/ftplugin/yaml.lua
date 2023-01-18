vim.bo.expandtab = true
vim.bo.shiftwidth = 2

local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
if vim.fn.match(dir, "/ansible/") >= 0 and vim.bo.filetype == "yaml" then
    vim.bo.filetype = "yaml.ansible"
elseif vim.bo.filetype == "yaml.ansible" then
    vim.bo.filetype = "yaml"
end

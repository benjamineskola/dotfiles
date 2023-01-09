vim.b.colorcolumn = tonumber(vim.fn.system([[yq '.Layout/LineLength.Max // 120' .rubocop.yml]]))
vim.bo.expandtab = true
vim.bo.shiftwidth = 2

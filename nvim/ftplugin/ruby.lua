vim.b.colorcolumn = tonumber(vim.fn.system([[yq '.Layout/LineLength.Max // 120' .rubocop.yml]]))

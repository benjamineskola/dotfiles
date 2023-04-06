vim.b.colorcolumn = tonumber(
    vim.fn.system(
        [[rustfmt --print-config current ]]
            .. vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
            .. [[ 2>/dev/null | grep '^max_width ' | cut -d '=' -f 2]]
    )
)
vim.bo.shiftwidth = 4

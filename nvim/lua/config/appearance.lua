vim.opt.termguicolors = true

local function set_dark_mode()
    local dark_mode = vim.fn.trim(
        vim.fn.system(
            [[osascript -l JavaScript -e 'Application("System Events").appearancePreferences.darkMode.get()']]
        )
    ) == "true" and "dark" or "light"

    if dark_mode ~= vim.o.background then
        vim.o.background = dark_mode
        require("lualine").setup()
    end
end

vim.cmd([[highlight SpellBad guisp=red]])

vim.api.nvim_create_autocmd({ "FocusGained", "CursorHold", "CursorHoldI" }, {
    callback = set_dark_mode,
    group = vim.api.nvim_create_augroup("dark_mode", { clear = true }),
})

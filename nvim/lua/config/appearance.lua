local function set_dark_mode()
    local dark_mode = vim.fn.trim(
        vim.fn.system(
            [[osascript -l JavaScript -e 'Application("System Events").appearancePreferences.darkMode.get()']]
        )
    )
    if dark_mode == "true" then
        vim.o.background = "dark"
        vim.cmd([[colo tokyonight-night]])
        require("lualine").setup()
    else
        vim.o.background = "light"
        vim.cmd([[colo tokyonight-day]])
        require("lualine").setup()
    end
end

vim.opt.termguicolors = true

vim.cmd([[highlight SpellBad guisp=red]])

vim.api.nvim_create_autocmd({ "FocusGained", "CursorHold", "CursorHoldI" }, {
    callback = set_dark_mode,
    group = vim.api.nvim_create_augroup("dark_mode", { clear = true }),
})
set_dark_mode()

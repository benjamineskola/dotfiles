local function dark_mode()
    local dark_mode = vim.fn.trim(
        vim.fn.system(
            [[osascript -l JavaScript -e 'Application("System Events").appearancePreferences.darkMode.get()']]
        )
    )
    if dark_mode == "true" then
        vim.o.background = "dark"
        vim.cmd([[colo tokyonight-night]])
    else
        vim.o.background = "light"
        vim.cmd([[colo tokyonight-day]])
    end
end

vim.opt.termguicolors = true

vim.cmd([[highlight SpellBad guisp=red]])

vim.api.nvim_create_autocmd({ "WinEnter", "CursorHold", "CursorHoldI" }, {
    callback = dark_mode,
    group = vim.api.nvim_create_augroup("dark_mode", { clear = true }),
})
dark_mode()

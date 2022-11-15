vim.opt.guifont = "Fira Code:h14"

vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_remember_window_size = true

local abbrev = require("utils").abbrev
abbrev("c", "bd", "Bdelete", { noreabbrev = true })
abbrev("c", "q", "Bdelete", { noreabbrev = true })
abbrev("c", "qa", "silent only!|bufdo Bdelete", { noreabbrev = true })
abbrev("c", "qall", "silent only!|bufdo Bdelete", { noreabbrev = true })
abbrev("c", "qa!", "silent only!|bufdo Bdelete", { noreabbrev = true })
abbrev("c", "qall!", "silent only!|bufdo Bdelete", { noreabbrev = true })
abbrev("c", "wq", "w|Bdelete", { noreabbrev = true })
abbrev("c", "wqa", "wa|silent only!|bufdo Bdelete", { noreabbrev = true })
abbrev("c", "wqall", "wa|silent only!|bufdo Bdelete", { noreabbrev = true })
abbrev("c", "wqa!", "wa!|silent only!|bufdo Bdelete", { noreabbrev = true })
abbrev("c", "wqall!", "wa!|silent only!|bufdo Bdelete", { noreabbrev = true })
abbrev("c", "x", "up", { noreabbrev = true })
abbrev("c", "xit", "update", { noreabbrev = true })

vim.keymap.set("n", "ZZ", "<Cmd>update<CR>", { noremap = true })
vim.keymap.set("n", "ZQ", "<Cmd>silent only!|bufdo Bdelete!<CR>", { noremap = true })

vim.keymap.set({ "c", "i" }, "<D-v>", "<C-R>+", { noremap = true })
vim.keymap.set({ "n", "v" }, "<D-v>", '"*p', { noremap = true })
vim.keymap.set("v", "<D-c>", '"*y', { noremap = true })
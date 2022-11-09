vim.opt.guifont = "Fira Code:h14"

vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_remember_window_size = true

local abbrev = require("utils").abbrev
abbrev("c", "bd", "Bdelete", { noreabbrev = true })
abbrev("c", "q", "Bdelete", { noreabbrev = true })
abbrev("c", "qa", "only!|bufdo Bdelete", { noreabbrev = true })
abbrev("c", "qall", "only!|bufdo Bdelete", { noreabbrev = true })
abbrev("c", "qa!", "only!|bufdo Bdelete", { noreabbrev = true })
abbrev("c", "qall!", "only!|bufdo Bdelete", { noreabbrev = true })
abbrev("c", "wq", "w|Bdelete", { noreabbrev = true })
abbrev("c", "wqa", "wa|only!|bufdo Bdelete", { noreabbrev = true })
abbrev("c", "wqall", "wa|only!|bufdo Bdelete", { noreabbrev = true })
abbrev("c", "wqa!", "wa!|only!|bufdo Bdelete", { noreabbrev = true })
abbrev("c", "wqall!", "wa!|only!|bufdo Bdelete", { noreabbrev = true })
abbrev("c", "x", "up", { noreabbrev = true })
abbrev("c", "xit", "update", { noreabbrev = true })

vim.keymap.set("n", "ZZ", "<Cmd>update<CR>", { noremap = true })
vim.keymap.set("n", "ZQ", "<Cmd>only!|bufdo Bdelete!<CR>", { noremap = true })

vim.keymap.set("c", "<D-v>", "<C-R>+", { noremap = true })
vim.keymap.set("i", "<D-v>", "<C-R>+", { noremap = true })
vim.keymap.set("n", "<D-v>", '"*p', { noremap = true })
vim.keymap.set("v", "<D-c>", '"*y', { noremap = true })
vim.keymap.set("v", "<D-v>", '"*p', { noremap = true })

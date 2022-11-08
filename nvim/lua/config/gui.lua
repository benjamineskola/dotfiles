vim.opt.guifont = "Fira Code:h14"

vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_remember_window_size = true

vim.cmd([[cnoreabbrev bd Bdelete]])
vim.cmd([[cnoreabbrev q Bdelete]])
vim.cmd([[cnoreabbrev qa only!\|bufdo Bdelete]])
vim.cmd([[cnoreabbrev qall only!\|bufdo Bdelete]])
vim.cmd([[cnoreabbrev qa! only!\|bufdo Bdelete!]])
vim.cmd([[cnoreabbrev qall! only!\|bufdo Bdelete!]])
vim.cmd([[cnoreabbrev wq w\|Bdelete]])
vim.cmd([[cnoreabbrev wqa wa\|only!\|bufdo Bdelete]])
vim.cmd([[cnoreabbrev wqall wa\|only!\|bufdo Bdelete]])
vim.cmd([[cnoreabbrev wqa! wa!\|only!\|bufdo Bdelete!]])
vim.cmd([[cnoreabbrev wqall! wa!\|only!\|bufdo Bdelete!]])
vim.cmd([[cnoreabbrev x up]])
vim.cmd([[cnoreabbrev xit update]])

vim.keymap.set("n", "ZZ", "<Cmd>update<CR>", { noremap = true })
vim.keymap.set("n", "ZQ", "<Cmd>only!|bufdo Bdelete!<CR>", { noremap = true })

vim.keymap.set("c", "<D-v>", "<C-R>+", { noremap = true })
vim.keymap.set("i", "<D-v>", "<C-R>+", { noremap = true })
vim.keymap.set("n", "<D-v>", '"*p', { noremap = true })
vim.keymap.set("v", "<D-c>", '"*y', { noremap = true })
vim.keymap.set("v", "<D-v>", '"*p', { noremap = true })

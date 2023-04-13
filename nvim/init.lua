vim.opt.belloff = "all"
vim.opt.concealcursor = "nc"
vim.opt.expandtab = true
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep $*"
vim.opt.hidden = true
vim.opt.history = 10000
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.g.mapleader = " "
vim.opt.modeline = false
vim.opt.mouse.a = true
vim.opt.number = true
vim.opt.pastetoggle = "<F10>"
vim.opt.scrolloff = 5
vim.opt.shell = "/bin/sh"
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.spell = true
vim.opt.spelllang = "en_gb"
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.undofile = true
vim.opt.viewoptions = "folds"

vim.cmd([[colo habamax]])
vim.cmd([[highlight SpellBad guisp=red]])

local map = vim.keymap.set

map("n", "<Leader>l", "<Cmd>nohl<CR>", { noremap = true })
map("c", "<C-A>", "<Home>", { noremap = true })

-- reformat selection/paragraph
map("v", "Q", "gw", { noremap = true })
map("n", "Q", "gwap", { noremap = true }) -- Overwrites default binding for Ex mode

-- close buffer/window
map("n", "<Leader>q", "<Cmd>bd<CR>", { noremap = true })
map("n", "<Leader>Q", "<Cmd>q<CR>", { noremap = true })

map("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })

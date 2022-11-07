require("plugins")

vim.opt.belloff = "all"
vim.opt.colorcolumn = "80"
vim.opt.concealcursor = "nc"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep $*"
vim.opt.hidden = true
vim.opt.history = 10000
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "nosplit"
vim.opt.mouse.a = true
vim.opt.modeline = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.pastetoggle = "<F10>"
vim.opt.scrolloff = 5
vim.opt.shell = "/bin/sh"
vim.opt.signcolumn = "yes"
vim.opt.spell = true
vim.opt.spelllang = "en_gb"
vim.opt.undofile = true
vim.opt.viewoptions = "folds"

if vim.g.neovide then
    require("ginit")
end

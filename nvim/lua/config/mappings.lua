---@diagnostic disable-next-line: unused-local
vim.g.mapleader = ","

local abbrev = require("utils").abbrev
local map = vim.keymap.set

map("n", "<Leader>l", "<Cmd>nohl<CR>", { noremap = true })

map("n", "<Leader>u", "<Cmd>MundoToggle<CR>", { noremap = true })

map("n", "<leader>b", function() require("telescope.builtin").buffers() end, { noremap = true })
map("n", "<Leader>f", function() require("telescope.builtin").find_files() end, { noremap = true })
map("n", "<Leader>g", function() require("telescope.builtin").live_grep() end, { noremap = true })
map("n", "<Leader>o", function() require("telescope.builtin").oldfiles() end, { noremap = true })
map({ "n", "v" }, "<Leader>x", function() vim.lsp.buf.code_action() end, { noremap = true })
map("n", "<leader>c", function() require("plugin.telescope").projects() end, { noremap = true })

-- avoid ex mode
map("n", "Q", "<nop>", { noremap = true })

map("n", "<Leader>d", "<Plug>DashSearch", { noremap = true })

map("n", "<Leader>tn", "<Cmd>TestNearest<CR>", { noremap = true })
map("n", "<Leader>tf", "<Cmd>TestFile<CR>", { noremap = true })
map("n", "<Leader>ts", "<Cmd>TestSuite<CR>", { noremap = true })
map("n", "<Leader>tl", "<Cmd>TestLast<CR>", { noremap = true })
map("n", "<Leader>tv", "<Cmd>TestVisit<CR>", { noremap = true })

map("c", "<C-A>", "<Home>", { noremap = true })

-- reformat selection/paragraph
map("v", "Q", "gw", { noremap = true })
map("n", "Q", "gwap", { noremap = true }) -- Overwrites default binding for Ex mode

-- close buffer/window
map("n", "<Leader>q", "<Cmd>bd<CR>", { noremap = true })
map("n", "<Leader>Q", "<Cmd>q<CR>", { noremap = true })

-- better regexes for search
map("n", "/", [[/\v]], { noremap = true })
map("v", "/", [[/\v]], { noremap = true })
abbrev("c", "s", "sm", { noreabbrev = true })
abbrev("c", "%s", "%sm", { noreabbrev = true })
abbrev("c", "'<,'>s", "'<,'>sm", { noreabbrev = true })

-- allow semicolon instead of colon for command mode
map("n", ";", ":", { noremap = true })

-- edit/source vim configs
local plugins_file = vim.fn.stdpath("config") .. "/lua/config/plugins.lua"
local mappings_file = vim.fn.stdpath("config") .. "/lua/config/mappings.lua"

map("n", "<Leader>vv", "<Cmd>edit $MYVIMRC<CR>")
map("n", "<Leader>vp", "<Cmd>edit " .. plugins_file .. "<CR>")
map("n", "<Leader>vm", "<Cmd>edit " .. mappings_file .. "<CR>")
map(
    "n",
    "<Leader>vf",
    "<Cmd>edit " .. vim.fn.stdpath("config") .. "/ftplugin/" .. vim.bo.filetype .. ".vim<CR>",
    { noremap = true }
)

map("n", "<Leader>sv", "<Cmd>source $MYVIMRC<CR>", { noremap = true })
map("n", "<Leader>sp", "<Cmd>runtime " .. plugins_file .. "<CR>", { noremap = true })
map("n", "<Leader>sm", "<Cmd>runtime " .. mappings_file .. "<CR>", { noremap = true })

-- run current file in a terminal
map("n", "<Leader>vr", "<Cmd>belowright split +terminal %<CR>", { noremap = true })
map(
    "n",
    -- "<expr>",
    "<Leader>vR",
    function() vim.cmd("terminal %:p " .. vim.fn.join(vim.fn.split(vim.fn.input("Parameters: "), " "), " ")) end,
    { noremap = true }
)

-- kill buffer with cmd-w
map("n", "<D-w>", "<Cmd>Bdelete<CR>", { noremap = true })
map("n", "<D-M-w>", "<Cmd>Bdelete!<CR>", { noremap = true })

map("n", "<leader>l", "<cmd>NvimTreeToggle<cr>", { noremap = true })

map("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })

map("n", "<leader>a", "<Cmd>:A<CR>", { noremap = true })

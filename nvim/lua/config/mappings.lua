vim.g.mapleader = ","

local abbrev = require("utils").abbrev
local map = vim.keymap.set

map("n", "<Leader>l", "<Cmd>nohl<CR>", { noremap = true })

map("n", "<Leader>u", "<Cmd>MundoToggle<CR>", { noremap = true })

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

-- run current file in a terminal
map("n", "<Leader>vr", function() vim.cmd("belowright split term://%:p") end, { noremap = true })
map(
    "n",
    "<Leader>vR",
    function()
        vim.cmd("belowright split term://%:p " .. vim.fn.join(vim.fn.split(vim.fn.input("Parameters: "), " "), " "))
    end,
    { noremap = true }
)

-- kill buffer with cmd-w
map("n", "<D-w>", "<Cmd>Bdelete<CR>", { noremap = true })
map("n", "<D-M-w>", "<Cmd>Bdelete!<CR>", { noremap = true })

map("n", "<leader>l", "<cmd>NvimTreeToggle<cr>", { noremap = true })

map("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })

map("n", "<leader>a", "<Cmd>:A<CR>", { noremap = true })

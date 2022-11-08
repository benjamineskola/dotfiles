---@diagnostic disable-next-line: unused-local
vim.g.mapleader = ","

vim.keymap.set("n", "<Leader>l", "<Cmd>nohl<CR>", { noremap = true })

vim.keymap.set("n", "<Leader>u", "<Cmd>MundoToggle<CR>", { noremap = true })

vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>", { noremap = true })
vim.keymap.set("n", "<Leader>f", "<cmd>Telescope find_files<cr>", { noremap = true })
vim.keymap.set("n", "<Leader>g", "<cmd>Telescope live_grep<cr>", { noremap = true })
vim.keymap.set("n", "<Leader>o", "<cmd>Telescope oldfiles<cr>", { noremap = true })
vim.keymap.set({ "n", "v" }, "<Leader>x", function()
    vim.lsp.buf.code_action()
end, { noremap = true })
vim.keymap.set("n", "<leader>c", function()
    require("telescope.builtin").find_files({
        find_command = {
            "sh",
            "-c",
            "fd --type d --max-depth 1 . $HOME/Code $HOME/Code/Work $HOME/Code/Personal; echo $XDG_CONFIG_HOME",
        },
    })
end, { noremap = true })

-- avoid ex mode
vim.keymap.set("n", "Q", "<nop>", { noremap = true })

vim.keymap.set("n", "<Leader>d", "<Plug>DashSearch", { noremap = true })

vim.keymap.set("n", "<Leader>tn", "<Cmd>TestNearest<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>tf", "<Cmd>TestFile<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>ts", "<Cmd>TestSuite<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>tl", "<Cmd>TestLast<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>tv", "<Cmd>TestVisit<CR>", { noremap = true })

vim.keymap.set("c", "<C-A>", "<Home>", { noremap = true })

-- reformat selection/paragraph
vim.keymap.set("v", "Q", "gw", { noremap = true })
vim.keymap.set("n", "Q", "gwap", { noremap = true }) -- Overwrites default binding for Ex mode

-- close buffer/window
vim.keymap.set("n", "<Leader>q", "<Cmd>bd<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>Q", "<Cmd>q<CR>", { noremap = true })

-- better regexes for search
vim.keymap.set("n", "/", [[/\v]], { noremap = true })
vim.keymap.set("v", "/", [[/\v]], { noremap = true })
vim.cmd([[cnoreabbrev s sm]])
vim.cmd([[cnoreabbrev %s %sm]])
vim.cmd([[cnoreabbrev '<,'>s '<,'>sm]])

-- allow semicolon instead of colon for command mode
vim.keymap.set("n", ";", ":", { noremap = true })

-- edit/source vim configs
local plugins_file = vim.fn.stdpath("config") .. "/lua/config/plugins.lua"
local mappings_file = vim.fn.stdpath("config") .. "/lua/config/mappings.lua"

vim.keymap.set("n", "<Leader>vv", "<Cmd>edit $MYVIMRC<CR>")
vim.keymap.set("n", "<Leader>vp", "<Cmd>edit " .. plugins_file .. "<CR>")
vim.keymap.set("n", "<Leader>vm", "<Cmd>edit " .. mappings_file .. "<CR>")
vim.keymap.set(
    "n",
    "<Leader>vf",
    "<Cmd>edit " .. vim.fn.stdpath("config") .. "/ftplugin/" .. vim.bo.filetype .. ".vim<CR>",
    { noremap = true }
)

vim.keymap.set("n", "<Leader>sv", "<Cmd>source $MYVIMRC<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>sp", "<Cmd>runtime " .. plugins_file .. "<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>sm", "<Cmd>runtime " .. mappings_file .. "<CR>", { noremap = true })

-- run current file in a terminal
vim.keymap.set("n", "<Leader>vr", "<Cmd>belowright split +terminal %<CR>", { noremap = true })
vim.keymap.set(
    "n",
    -- "<expr>",
    "<Leader>vR",
    function()
        vim.cmd("terminal %:p " .. vim.fn.join(vim.fn.split(vim.fn.input("Parameters: "), " "), " "))
    end,
    { noremap = true }
)

-- kill buffer with cmd-w
vim.keymap.set("n", "<D-w>", "<Cmd>Bdelete<CR>", { noremap = true })
vim.keymap.set("n", "<D-M-w>", "<Cmd>Bdelete!<CR>", { noremap = true })

vim.keymap.set("n", "<leader>l", "<cmd>NvimTreeToggle<cr>", { noremap = true })

local M = {
    "mfussenegger/nvim-dap",
    dependencies = {
        "mfussenegger/nvim-dap-python",
        "suketa/nvim-dap-ruby",
        "theHamsta/nvim-dap-virtual-text",
    },
    ft = { "python", "ruby" },
}

M.config = function()
    require("dap-python").setup()
    require("dap-ruby").setup()
    require("nvim-dap-virtual-text").setup({ commented = true })

    vim.keymap.set("n", "<leader>zd", function() require("dap").continue() end)
    vim.keymap.set("n", "<leader>zn", function() require("dap").step_into() end)
    vim.keymap.set("n", "<leader>zN", function() require("dap").step_over() end)
    vim.keymap.set("n", "<leader>zq", function() require("dap").step_out() end)
    vim.keymap.set("n", "<leader>zr", function() require("dap").repl.open() end)
    vim.keymap.set("n", "<leader>zb", function() require("dap").toggle_breakpoint() end)
end

return M

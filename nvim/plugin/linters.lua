local ruby_linter = "standardrb"
if require("utils").has_rubocop then
    ruby_linter = "rubocop"
end

require("lint").linters.luacheck_vim = function()
    local luacheck = require("lint").linters.luacheck
    luacheck.cmd = vim.fn.stdpath("cache")
        .. "/packer_hererocks/"
        .. string.gsub(jit.version, "LuaJIT ", "")
        .. "/bin/luacheck"
    luacheck.args = vim.list_extend({ "--globals=jit", "--globals=vim" }, luacheck.args)
    return luacheck
end

require("lint").linters.tsc = function()
    return {
        cmd = "tsc",
        args = { "--noEmit", "--project", vim.fn.getcwd() },
        stdin = false,
        ignore_exitcode = true,
        parser = require("lint.parser").from_pattern(
            "(%g+)%((%d+),(%d+)%): (%a+) (%g+): (.+)",
            { "file", "lnum", "col", "severity", "code", "message" }
        ),
    }
end

require("lint").linters_by_ft = {
    go = { "golangcilint" },
    lua = { "luacheck_vim" },
    ruby = { ruby_linter },
    sh = { "shellcheck" },
    typescript = { "tsc" },
    vim = { "vint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})
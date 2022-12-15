local M = {
    copy_link = {
        NetNewsWire = function()
            local _, result = hs.osascript.javascript("Application('NetNewsWire').currentArticle.url()")
            return result
        end,
    },
    markdown_link = {
        NetNewsWire = function()
            local _, url = hs.osascript.javascript("Application('NetNewsWire').currentArticle.url()")
            local _, title = hs.osascript.javascript("Application('NetNewsWire').currentArticle.title()")
            return "[" .. title .. "](" .. url .. ")"
        end,
    },
}

hs.hotkey.bind({ "cmd", "shift" }, "c", function()
    local win = hs.window.focusedWindow()
    local app_name = win:application():name()
    if M.copy_link[app_name] then hs.pasteboard.setContents(M.copy_link[app_name]()) end
end)

hs.hotkey.bind({ "cmd", "shift" }, "m", function()
    local win = hs.window.focusedWindow()
    local app_name = win:application():name()
    if M.markdown_link[app_name] then hs.pasteboard.setContents(M.markdown_link[app_name]()) end
end)

return M

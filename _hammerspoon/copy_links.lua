local M = {}

M.get_url = {
    NetNewsWire = function()
        local _, result = hs.osascript.javascript("Application('NetNewsWire').currentArticle.url()")
        return result
    end,
    Safari = function()
        local _, result = hs.osascript.javascript("Application('Safari').documents[0].url()")
        return result
    end,
}

M.get_title = {
    NetNewsWire = function()
        local _, title = hs.osascript.javascript("Application('NetNewsWire').currentArticle.title()")
        return title
    end,
    Safari = function()
        local _, title = hs.osascript.javascript("Application('Safari').documents[0].name()")
        return title
    end,
}

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "c", function()
    local win = hs.window.focusedWindow()
    local app_name = win:application():name()
    if M.get_url[app_name] then hs.pasteboard.setContents(M.get_url[app_name]()) end
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "m", function()
    local win = hs.window.focusedWindow()
    local app_name = win:application():name()
    if M.get_url[app_name] then
        if M.get_title[app_name] then
            local url = M.get_url[app_name]()
            local title = M.get_title[app_name]()
            if url and title then
                hs.pasteboard.setContents("[" .. title .. "](" .. url .. ")")
                return
            end
        end
        hs.pasteboard.setContents(M.get_url[app_name]())
    end
end)

return M

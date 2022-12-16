local M = {}

local bear_token = hs.json.read(os.getenv("XDG_CONFIG_HOME") .. "/private/hs-bear.conf").token
local function get_current_bear_note(link)
    local bear = require("Bear")
    bear.init(bear_token)
    local note = bear:getCurrent()
    if link then note.link = bear:getLink(note.identifier) end
    return note
end

M.get_url = {
    Bear = function()
        local note = assert(get_current_bear_note(true))
        return note.link
    end,
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
    Bear = function()
        local note = assert(get_current_bear_note())
        return note.title
    end,
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
    if M.get_url[app_name] then
        local url = M.get_url[app_name]()
        if url then hs.pasteboard.setContents(url) end
    end
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

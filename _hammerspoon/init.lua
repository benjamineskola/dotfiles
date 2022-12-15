require("copy_links")

local function reloadConfig(files)
    local doReload = false
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then doReload = true end
    end
    if doReload then hs.reload() end
end
local configWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", function(files)
    reloadConfig(files)

    hs.alert.show("Config loaded")
end)
configWatcher:start()

local function applicationWatcher(appName, eventType, appObject)
    if eventType == hs.application.watcher.activated then
        if appName == "PDF Expert" then
            local _, mode = hs.osascript.javascript('Application("System Events").appearancePreferences.darkMode.get()')
            local modeName = mode and "Night" or "Day"

            appObject:selectMenuItem({ "View", "Theme", modeName })
        end
    end
end
local appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

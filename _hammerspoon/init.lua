require("copy_links")

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

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

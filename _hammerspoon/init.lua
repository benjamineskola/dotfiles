hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

local function darkModeSwitcher(appName, eventType, appObject)
    local apps = {
        ["PDF Expert"] = { modeNames = { "Night", "Day" }, menuItem = { "View", "Theme" } },
        Highlights = { modeNames = { "Night", "Default" }, menuItem = { "View", "PDF Appearance" } },
    }

    if eventType == hs.application.watcher.activated or eventType == hs.application.watcher.unhidden then
        local appData = apps[appName]
        if appData then
            local _, darkMode =
                hs.osascript.javascript('Application("System Events").appearancePreferences.darkMode.get()')
            local modeName = darkMode and appData.modeNames[1] or appData.modeNames[2]
            local menuItem = appData.menuItem
            table.insert(menuItem, #menuItem + 1, modeName)
            appObject:selectMenuItem(menuItem)
        end
    end
end
local appWatcher = hs.application.watcher.new(darkModeSwitcher)
appWatcher:start()

local screen_watcher = hs.screen.watcher.new(function()
    local logger = hs.logger.new("noclamshell")
    logger.df("Received hs.screen.watcher event")
    local screens = hs.screen.allScreens()
    logger.df("  Screens: %s", hs.inspect(screens))
    if #screens > 0 and hs.fnutils.every(screens, function(s) return s:name() ~= "Color LCD" end) then
        logger.df("  'Color LCD' display is gone but other screens remain - detecting this as 'lid close'")
        -- the following check is from pirj/noclamshell to query the actual state
        local lid_closed = os.execute("ioreg -r -k AppleClamshellState | grep AppleClamshellState | grep Yes")
        if lid_closed then
            hs.alert("detected lid closed the hard way")
            os.execute("pmset sleepnow")
        end
    end
end)
screen_watcher:start()

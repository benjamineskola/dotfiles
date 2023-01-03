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

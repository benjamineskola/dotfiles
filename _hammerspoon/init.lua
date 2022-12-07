function reloadConfig(files)
    doReload = false
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then doReload = true end
    end
    if doReload then hs.reload() end
end
configWatcher = hs.pathwatcher
    .new(os.getenv("HOME") .. "/.hammerspoon/", function(files)
        reloadConfig(files)

        hs.alert.show("Config loaded")
    end)
    :start()

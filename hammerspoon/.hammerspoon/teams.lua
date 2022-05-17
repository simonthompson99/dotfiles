local sendToAllTeamsWindows = true
local pushToTalk = false

function sendMuteKey(application)
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.shift, true):post(application)
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.cmd, true):post(application)
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.m, true):post(application)
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.m, false):post(application)
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.shift, false):post(application)
    hs.eventtap.event.newKeyEvent(hs.keycodes.map.cmd, false):post(application)
end

function toggleMsTeamsMute()
    local msTeams = hs.appfinder.appFromName("Microsoft Teams")
    if msTeams == nil then
        print("A")
        return
    end

    -- save current main MS Teams window and send mute/unmute to it
    initialMainWindow = msTeams:mainWindow()
    sendMuteKey(msTeams)

    -- stop if not sending mute key to other windows
    if not sendToAllTeamsWindows then
        print("B")
        return
    end

    for key, window in pairs(msTeams:allWindows()) do
        if window:title() == "Microsoft Teams Notification"
            or window == initialMainWindow
            or window:isMinimized()
            then
            print("C")
            goto continue
        end

        -- make window main and send mute/unmute to it
        window:becomeMain()
        sendMuteKey(msTeams)

        -- no real continue in Lua...
        ::continue::
    end

    -- restore initial main window
    if initialMainWindow ~= nil and msTeams:mainWindow() ~= initialMainWindow then
        print("D")
        initialMainWindow:becomeMain()
    end
end

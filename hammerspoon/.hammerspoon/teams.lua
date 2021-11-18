-- from https://github.com/justintout/.hammerspoon/blob/main/teams.lua
teams = {}

-- mute/unmute teams 
teams.toggleMute = function()
    if not teams.app then 
        if not hs.application.find("Microsoft Teams") then return end
        teams.app = hs.application.find("Microsoft Teams")
    end
    hs.eventtap.keyStroke({"cmd", "shift"}, "m", 0, teams.app)
end

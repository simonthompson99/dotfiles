require('keyboard')
-- Load Hammerspoon bits from https://github.com/jasonrudolph/keyboard
hs.application.enableSpotlightForNameSearches(true)
--hs.loadSpoon('Caffeine')
--
local caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
    if state then
        caffeine:setTitle("🌕")
    else
        caffeine:setTitle("🌑")
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

require("teams")
hs.hotkey.bind({'shift', 'ctrl', 'alt', 'cmd'}, ";", toggleMsTeamsMute)

require("toggle_audio")
hs.hotkey.bind({'shift', 'ctrl', 'alt', 'cmd'}, "a", toggle_audio_output)


--hs.loadSpoon("Pomodoro")

-- hs.loadSpoon("MicMute")
-- spoon.MicMute:bindHotkeys({toggle = {{'shift', 'ctrl', 'alt', 'cmd'}, ";"}}, 0.75)

--local hyper = {"ctrl", "alt", "cmd"}
--
--hs.loadSpoon("MiroWindowsManager")
--
--hs.window.animationDuration = 0.0
--spoon.MiroWindowsManager:bindHotkeys({
--  up = {hyper, "k"},
--  right = {hyper, "i"},
--  down = {hyper, "j"},
--  left = {hyper, "u"},
--  fullscreen = {hyper, "return"}
--})
--
--hs.hotkey.bind(hyper, "l", function()
--  -- move the focused window one display to the right
--  local win = hs.window.focusedWindow()
--  win:moveOneScreenEast()
--end)
--
--hs.hotkey.bind(hyper, "h", function()
--  -- move the focused window one display to the left
--  local win = hs.window.focusedWindow()
--  win:moveOneScreenWest()
--end)

-- from https://github.com/kyounger/hammerspoon/blob/master/audio_output_toggle.lua
function toggle_audio_output()
    -- Define audio device names for headphone/speaker switching

    local current =            hs.audiodevice.defaultOutputDevice()
    local macbookProSpeakers = hs.audiodevice.findOutputByName("MacBook Pro Speakers")
    local externalHeadphones = hs.audiodevice.findOutputByName("External Headphones")
    --local yetiOutput =         hs.audiodevice.findOutputByName("Yeti Stereo Microphone")
    --local desktopSpeakers =    hs.audiodevice.findOutputByName("DisplayPort")

    --print(current:name())
    --print(macbookProSpeakers:name())
    --print(externalHeadphones:name())

    if not externalHeadphones then
        hs.notify.new({title="Hammerspoon", informativeText="ERROR: Headphones missing.", ""}):send()
        return
    end

    if current:name() == macbookProSpeakers:name() then
        externalHeadphones:setDefaultOutputDevice()
    else
        macbookProSpeakers:setDefaultOutputDevice()
    end
    hs.notify.new({
          title='Hammerspoon',
            informativeText='Default output device: '..hs.audiodevice.defaultOutputDevice():name()
        }):send()
end

return toggle_audio_output

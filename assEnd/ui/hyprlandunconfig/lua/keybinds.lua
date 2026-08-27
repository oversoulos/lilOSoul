-- App Launchers & Controls
hl.bind({ "SUPER" }, "Return", function() hl.dsp.exec("ghostty") end)
hl.bind({ "SUPER" }, "Q", function() hl.dsp.killactive() end)
hl.bind({ "SUPER" }, "E", function() hl.dsp.exec("ghostty -e yazi") end)
hl.bind({ "SUPER" }, "R", function() hl.dsp.exec("wofi --show drun") end)
hl.bind({ "SUPER" }, "C", function() hl.dsp.exec("hypr-live-config") end)
hl.bind({ "SUPER" }, "M", function() hl.dsp.exit() end)
hl.bind({ "SUPER" }, "V", function() hl.dsp.togglefloating() end)
hl.bind({ "SUPER" }, "F", function() hl.dsp.fullscreen() end)

-- OMNI-SEARCH ENGINE (SUPER + Space)
hl.bind({ "SUPER" }, "Space", function()
  hl.dsp.exec("wofi --show drun --prompt 'Search Apps, Notes & Files...' --location bottom --yoffset -20")
end)

-- Quake Terminal Drawer (SUPER + ~)
hl.bind({ "SUPER" }, "grave", function()
  hl.dsp.togglespecialworkspace("dropdown")
end)

-- AMD GPU & System Monitor Drawer (SUPER + D)
hl.bind({ "SUPER" }, "D", function()
  hl.dsp.togglespecialworkspace("sysmon")
end)

-- Clipboard Manager (SUPER + Y)
hl.bind({ "SUPER" }, "Y", function()
  hl.dsp.exec("cliphist list | wofi --dmenu | cliphist decode | wl-copy")
end)

-- EMOJI PICKER (SUPER + .)
hl.bind({ "SUPER" }, "period", function()
  hl.dsp.exec("bemoji -t")
end)

-- WALLPAPER GALLERY (SUPER + W)
hl.bind({ "SUPER" }, "W", function()
  hl.dsp.exec("waypaper")
end)

-- AI VOICE DICTATION (F5 Toggle)
hl.bind({}, "F5", function()
  hl.dsp.exec("whisper-dictation-toggle")
end)

-- F5 Voice Dictation
hl.bind({}, "F5", function()
  hl.dsp.exec("nerd-dictation begin --vosk-model-dir=~/.config/nerd-dictation/model")
end)

hl.bind({ "SHIFT" }, "F5", function()
  hl.dsp.exec("nerd-dictation end")
end)

-- Hold F5 for push-to-talk
hl.bindr({}, "F5", function()
  hl.dsp.exec("nerd-dictation end")
end)

-- Toggle whisper-dictation with SUPER+Space (or any key you like)
hl.bind({ "SUPER" }, "Space", function()
  hl.dsp.exec("whisper-dictation-toggle")
end)
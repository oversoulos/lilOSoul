-- dictation/main.lua - Voice Dictation Controller
local Widget = require("quickshell.ui.widgets")
local Window = Widget.Window
local Label = Widget.Label
local Button = Widget.Button
local Box = Widget.Box
local Row = Widget.Row
local Col = Widget.Col
local Color = require("quickshell.graphics.color")
local Screen = require("quickshell.screen")

local screen = Screen.primary

return Window {
  width = 400,
  height = 200,
  x = (screen.width / 2) - 200,
  y = (screen.height / 2) - 100,
  visible = true,
  anchor = { "center" },
  backgroundColor = Color.rgba(30, 30, 40, 0.95),
  borderRadius = 16,
  borderWidth = 2,
  borderColor = Color.rgba(187, 154, 247, 0.4),
  padding = 24,
  
  child = Col {
    spacing = 12,
    children = {
      Label {
        text = "🎤 Voice Dictation",
        font = "sans 20 bold",
        color = Color.rgba(255, 255, 255, 1)
      },
      Label {
        text = "Press F5 to start, Shift+F5 to end",
        font = "sans 14",
        color = Color.rgba(255, 255, 255, 0.6)
      },
      Row {
        spacing = 12,
        children = {
          Button {
            padding = 12,
            backgroundColor = Color.rgba(60, 200, 60, 0.3),
            hoverBackgroundColor = Color.rgba(60, 200, 60, 0.6),
            cornerRadius = 8,
            onClick = function()
              os.execute("nerd-dictation begin --vosk-model-dir=~/.config/nerd-dictation/model &")
            end,
            child = Label {
              text = "▶ Start",
              color = Color.rgba(255, 255, 255, 1)
            }
          },
          Button {
            padding = 12,
            backgroundColor = Color.rgba(200, 60, 60, 0.3),
            hoverBackgroundColor = Color.rgba(200, 60, 60, 0.6),
            cornerRadius = 8,
            onClick = function()
              os.execute("nerd-dictation end &")
            end,
            child = Label {
              text = "⏹ Stop",
              color = Color.rgba(255, 255, 255, 1)
            }
          },
          Button {
            padding = 12,
            backgroundColor = Color.rgba(60, 60, 200, 0.3),
            hoverBackgroundColor = Color.rgba(60, 60, 200, 0.6),
            cornerRadius = 8,
            onClick = function()
              os.execute("wl-copy $(cat ~/.config/nerd-dictation/last.txt) &")
            end,
            child = Label {
              text = "📋 Copy Last",
              color = Color.rgba(255, 255, 255, 1)
            }
          }
        }
      }
    }
  }
}
-- dashboards/characterCards/main.lua
local Widget = require("quickshell.ui.widgets")
local Window = Widget.Window
local Label = Widget.Label
local Button = Widget.Button
local Box = Widget.Box
local Row = Widget.Row
local Col = Widget.Col
local Color = require("quickshell.graphics.color")
local Screen = require("quickshell.screen")
local Timer = require("quickshell.timer")

local screen = Screen.primary

-- Load character cards from config
local function loadCards(container)
  local handle = io.popen("cat ~/.config/ovrOS/cards/" .. container .. "/*.yaml 2>/dev/null")
  local result = handle:read("*a")
  handle:close()
  -- Parse YAML (simplified, would use a proper parser)
  return result
end

-- Character Card UI
local function CharacterCard(card)
  return Box {
    width = 300,
    height = 400,
    backgroundColor = Color.rgba(30, 30, 40, 0.95),
    borderRadius = 12,
    borderWidth = 2,
    borderColor = Color.rgba(187, 154, 247, 0.4),
    padding = 16,
    child = Col {
      spacing = 8,
      children = {
        -- Header
        Row {
          spacing = 8,
          children = {
            Label {
              text = card.icon,
              font = "sans 24",
              color = Color.rgba(255, 255, 255, 1)
            },
            Label {
              text = card.name,
              font = "sans 18 bold",
              color = Color.rgba(255, 255, 255, 1)
            },
            Label {
              text = "Lv." .. card.level,
              font = "sans 14",
              color = Color.rgba(187, 154, 247, 1)
            }
          }
        },
        
        -- Description
        Label {
          text = card.description,
          font = "sans 12",
          color = Color.rgba(255, 255, 255, 0.7),
          wrap = true
        },
        
        Box {
          height = 1,
          backgroundColor = Color.rgba(255, 255, 255, 0.1)
        },
        
        -- Skills (with bars)
        Col {
          spacing = 4,
          children = (function()
            local items = {}
            for _, skill in ipairs(card.skills) do
              table.insert(items, Row {
                spacing = 8,
                children = {
                  Label {
                    text = skill.name,
                    font = "sans 12",
                    color = Color.rgba(255, 255, 255, 0.8),
                    width = 80
                  },
                  Box {
                    width = 120,
                    height = 8,
                    backgroundColor = Color.rgba(60, 60, 80, 0.5),
                    borderRadius = 4,
                    child = Box {
                      width = (skill.level / skill.max) * 120,
                      height = 8,
                      backgroundColor = Color.rgba(187, 154, 247, 1),
                      borderRadius = 4
                    }
                  },
                  Label {
                    text = skill.level .. "/" .. skill.max,
                    font = "sans 10",
                    color = Color.rgba(255, 255, 255, 0.5)
                  }
                }
              })
            end
            return items
          end)()
        },
        
        Box {
          height = 1,
          backgroundColor = Color.rgba(255, 255, 255, 0.1)
        },
        
        -- Tools
        Label {
          text = "🛠️ Tools:",
          font = "sans 12 bold",
          color = Color.rgba(255, 255, 255, 0.7)
        },
        Label {
          text = table.concat(card.tools, " • "),
          font = "sans 11",
          color = Color.rgba(255, 255, 255, 0.6)
        },
        
        Box {
          height = 1,
          backgroundColor = Color.rgba(255, 255, 255, 0.1)
        },
        
        -- Timer & Status
        Row {
          spacing = 8,
          children = {
            Label {
              text = "⏱️ " .. card.timer,
              font = "sans 12",
              color = Color.rgba(100, 200, 100, 1)
            },
            Label {
              text = card.status,
              font = "sans 12",
              color = Color.rgba(200, 200, 100, 1)
            }
          }
        },
        
        -- Actions
        Row {
          spacing = 8,
          children = {
            Button {
              padding = 8,
              backgroundColor = Color.rgba(60, 60, 200, 0.3),
              hoverBackgroundColor = Color.rgba(60, 60, 200, 0.6),
              cornerRadius = 6,
              onClick = function()
                os.execute("ovrOS enter-role " .. card.id)
              end,
              child = Label {
                text = "▶ Enter",
                color = Color.rgba(255, 255, 255, 1),
                font = "sans 12"
              }
            },
            Button {
              padding = 8,
              backgroundColor = Color.rgba(200, 60, 60, 0.3),
              hoverBackgroundColor = Color.rgba(200, 60, 60, 0.6),
              cornerRadius = 6,
              onClick = function()
                os.execute("ovrOS exit-role " .. card.id)
              end,
              child = Label {
                text = "⏹ Exit",
                color = Color.rgba(255, 255, 255, 1),
                font = "sans 12"
              }
            },
            Button {
              padding = 8,
              backgroundColor = Color.rgba(60, 200, 60, 0.3),
              hoverBackgroundColor = Color.rgba(60, 200, 60, 0.6),
              cornerRadius = 6,
              onClick = function()
                os.execute("ovrOS update-resume " .. card.id)
              end,
              child = Label {
                text = "📄 Resume",
                color = Color.rgba(255, 255, 255, 1),
                font = "sans 12"
              }
            }
          }
        }
      }
    }
  }
end

-- Master Window
return Window {
  width = 1200,
  height = 800,
  x = (screen.width / 2) - 600,
  y = (screen.height / 2) - 400,
  visible = true,
  anchor = { "center" },
  backgroundColor = Color.rgba(20, 20, 30, 0.95),
  borderRadius = 16,
  borderWidth = 2,
  borderColor = Color.rgba(187, 154, 247, 0.3),
  padding = 24,
  child = Col {
    spacing = 16,
    children = {
      -- Header
      Row {
        spacing = 12,
        children = {
          Label {
            text = "📋 Character Cards",
            font = "sans 24 bold",
            color = Color.rgba(255, 255, 255, 1)
          },
          Label {
            text = "Select your role and enter focus mode",
            font = "sans 14",
            color = Color.rgba(255, 255, 255, 0.5)
          }
        }
      },
      
      -- Cards grid (would be populated from config)
      Row {
        spacing = 12,
        children = {
          -- Placeholder cards
          CharacterCard({
            id = "graphic-designer",
            icon = "🎨",
            name = "Graphic Designer",
            level = 12,
            description = "Creates visual concepts and brand identities.",
            skills = {
              { name = "Vector Art", level = 8, max = 10 },
              { name = "Photo Editing", level = 6, max = 10 },
              { name = "Logo Design", level = 9, max = 10 }
            },
            tools = {"GIMP", "Inkscape", "Krita"},
            timer = "2:47:12",
            status = "In Progress"
          }),
          CharacterCard({
            id = "game-dev",
            icon = "🎮",
            name = "Game Developer",
            level = 8,
            description = "Builds interactive experiences and games.",
            skills = {
              { name = "Unity", level = 7, max = 10 },
              { name = "C#", level = 6, max = 10 },
              { name = "3D Modeling", level = 5, max = 10 }
            },
            tools = {"Godot", "Blender", "Aseprite"},
            timer = "1:23:45",
            status = "Paused"
          }),
          -- More cards...
        }
      }
    }
  }
}
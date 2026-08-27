-- widgets.lua - All-in-one widget dashboard
local Widget = require("quickshell.ui.widgets")
local Window = Widget.Window
local Label = Widget.Label
local Button = Widget.Button
local Box = Widget.Box
local Row = Widget.Row
local Col = Widget.Col
local Color = require("quickshell.graphics.color")
local Screen = require("quickshell.screen")

-- ─── CLOCK WIDGET ────────────────────────────────────────────
local function ClockWidget()
  local clockLabel = Label {
    text = os.date("%H:%M:%S"),
    font = "sans 48 bold",
    color = Color.rgba(255, 255, 255, 1)
  }
  
  local dateLabel = Label {
    text = os.date("%A, %B %d, %Y"),
    font = "sans 16",
    color = Color.rgba(255, 255, 255, 0.7)
  }
  
  -- Update every second
  local timer = require("quickshell.timer")
  timer.every(1, function()
    clockLabel.text = os.date("%H:%M:%S")
  end)
  
  return Col {
    spacing = 4,
    children = { clockLabel, dateLabel }
  }
end

-- ─── CALENDAR WIDGET ──────────────────────────────────────────
local function CalendarWidget()
  local days = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"}
  local today = os.date("%d")
  local month = os.date("%B")
  local year = os.date("%Y")
  
  -- Get first day of month
  local firstDay = os.date("*t", os.time{year=os.date("%Y"), month=os.date("%m"), day=1})
  local startOffset = firstDay.wday - 1  -- 0 = Sunday
  
  -- Get days in month
  local daysInMonth = 31
  if month == "February" then
    daysInMonth = 28
    if os.date("%Y") % 4 == 0 then daysInMonth = 29 end
  elseif month == "April" or month == "June" or month == "September" or month == "November" then
    daysInMonth = 30
  end
  
  -- Build calendar grid
  local grid = {}
  local row = {}
  
  -- Blank days before month starts
  for i = 1, startOffset do
    table.insert(row, Label { text = "", width = 32 })
  end
  
  for day = 1, daysInMonth do
    local isToday = (day == tonumber(today))
    table.insert(row, Label {
      text = tostring(day),
      width = 32,
      textAlign = "center",
      font = isToday and "sans 14 bold" or "sans 14",
      color = isToday and Color.rgba(187, 154, 247, 1) or Color.rgba(255, 255, 255, 0.8),
      backgroundColor = isToday and Color.rgba(60, 60, 80, 0.5) or Color.rgba(0, 0, 0, 0)
    })
    
    if #row == 7 then
      table.insert(grid, Row { spacing = 4, children = row })
      row = {}
    end
  end
  
  -- Fill remaining
  while #row > 0 and #row < 7 do
    table.insert(row, Label { text = "", width = 32 })
    if #row == 7 then
      table.insert(grid, Row { spacing = 4, children = row })
      row = {}
    end
  end
  
  return Col {
    spacing = 8,
    children = {
      Label {
        text = month .. " " .. year,
        font = "sans 18 bold",
        color = Color.rgba(255, 255, 255, 1)
      },
      Row {
        spacing = 4,
        children = (function()
          local header = {}
          for _, day in ipairs(days) do
            table.insert(header, Label {
              text = day,
              width = 32,
              textAlign = "center",
              font = "sans 12 bold",
              color = Color.rgba(255, 255, 255, 0.6)
            })
          end
          return header
        end)()
      },
      unpack(grid)
    }
  }
end

-- ─── MAIN WINDOW ─────────────────────────────────────────────
local screen = Screen.primary

return Window {
  width = 450,
  height = 450,
  x = (screen.width / 2) - 225,
  y = (screen.height / 2) - 225,
  visible = true,
  anchor = { "center" },
  backgroundColor = Color.rgba(30, 30, 40, 0.95),
  borderRadius = 16,
  borderWidth = 2,
  borderColor = Color.rgba(187, 154, 247, 0.4),
  padding = 24,
  
  child = Col {
    spacing = 16,
    children = {
      ClockWidget(),
      Box {
        height = 1,
        backgroundColor = Color.rgba(255, 255, 255, 0.1)
      },
      CalendarWidget(),
      Box {
        height = 1,
        backgroundColor = Color.rgba(255, 255, 255, 0.1)
      },
      Row {
        spacing = 12,
        children = {
          Button {
            padding = 8,
            backgroundColor = Color.rgba(60, 60, 80, 0.8),
            hoverBackgroundColor = Color.rgba(187, 154, 247, 0.3),
            cornerRadius = 8,
            onClick = function() os.execute("gnome-calculator &") end,
            child = Label {
              text = "🧮 Calculator",
              color = Color.rgba(255, 255, 255, 1)
            }
          },
          Button {
            padding = 8,
            backgroundColor = Color.rgba(60, 60, 80, 0.8),
            hoverBackgroundColor = Color.rgba(187, 154, 247, 0.3),
            cornerRadius = 8,
            onClick = function() os.execute("gnome-clocks &") end,
            child = Label {
              text = "🕐 Clocks",
              color = Color.rgba(255, 255, 255, 1)
            }
          },
          Button {
            padding = 8,
            backgroundColor = Color.rgba(60, 60, 80, 0.8),
            hoverBackgroundColor = Color.rgba(187, 154, 247, 0.3),
            cornerRadius = 8,
            onClick = function() os.execute("gnome-calendar &") end,
            child = Label {
              text = "📅 Calendar",
              color = Color.rgba(255, 255, 255, 1)
            }
          }
        }
      }
    }
  }
}
-- dashboards/widgets/gpumonitor/main.lua
local Widget = require("quickshell.ui.widgets")
local Window = Widget.Window
local Label = Widget.Label
local Box = Widget.Box
local Col = Widget.Col
local Color = require("quickshell.graphics.color")
local Screen = require("quickshell.screen")
local Timer = require("quickshell.timer")

local screen = Screen.primary

-- Function to get GPU stats
local function getGPUStats()
  local handle = io.popen("amdgpu_top --json 2>/dev/null | head -20")
  local result = handle:read("*a")
  handle:close()
  return result
end

-- Parse GPU data (simplified)
local function parseGPUData(raw)
  local data = {
    gpu = "0%",
    vram = "0MB",
    temp = "0°C",
    power = "0W"
  }
  
  -- Try to get real data from amdgpu_top
  for line in raw:gmatch("[^\n]+") do
    if line:match("GPU %d+") then
      if line:match("Usage: (%d+)%%") then
        data.gpu = line:match("Usage: (%d+)%%") .. "%"
      end
      if line:match("VRAM: (%d+)MB") then
        data.vram = line:match("VRAM: (%d+)MB") .. "MB"
      end
      if line:match("Temp: (%d+)°C") then
        data.temp = line:match("Temp: (%d+)°C") .. "°C"
      end
      if line:match("Power: (%d+)W") then
        data.power = line:match("Power: (%d+)W") .. "W"
      end
    end
  end
  
  return data
end

-- Main widget
local function GPUMonitor()
  local gpuLabel = Label { text = "⚡ GPU: 0%", font = "sans 14 bold", color = Color.rgba(255, 255, 255, 1) }
  local vramLabel = Label { text = "💾 VRAM: 0MB", font = "sans 14", color = Color.rgba(255, 255, 255, 0.8) }
  local tempLabel = Label { text = "🌡️ Temp: 0°C", font = "sans 14", color = Color.rgba(255, 255, 255, 0.8) }
  local powerLabel = Label { text = "⚡ Power: 0W", font = "sans 14", color = Color.rgba(255, 255, 255, 0.8) }
  
  -- Update every 2 seconds
  Timer.every(2, function()
    local raw = getGPUStats()
    local stats = parseGPUData(raw)
    gpuLabel.text = "⚡ GPU: " .. stats.gpu
    vramLabel.text = "💾 VRAM: " .. stats.vram
    tempLabel.text = "🌡️ Temp: " .. stats.temp
    powerLabel.text = "⚡ Power: " .. stats.power
  end)
  
  return Window {
    width = 280,
    height = 200,
    x = 20,
    y = 100,
    visible = true,
    anchor = { "top", "left" },
    backgroundColor = Color.rgba(30, 30, 40, 0.9),
    borderRadius = 12,
    borderWidth = 1,
    borderColor = Color.rgba(187, 154, 247, 0.3),
    padding = 16,
    child = Col {
      spacing = 8,
      children = {
        Label { text = "🖥️ GPU Monitor (Vega 7)", font = "sans 14 bold", color = Color.rgba(187, 154, 247, 1) },
        Box { height = 1, backgroundColor = Color.rgba(255, 255, 255, 0.1) },
        gpuLabel,
        vramLabel,
        tempLabel,
        powerLabel
      }
    }
  }
end

return GPUMonitor()
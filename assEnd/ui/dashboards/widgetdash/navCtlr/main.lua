-- navCtlr - Navigation Controller for ovrOS Dashboards
-- ============================================================================
-- A floating panel that lets you switch between dashboard views.
-- SUPER + N to toggle it.
-- ============================================================================

local Widget = require("quickshell.ui.widgets")
local Window = Widget.Window
local Label = Widget.Label
local Button = Widget.Button
local Row = Widget.Row
local Col = Widget.Col
local Box = Widget.Box
local Rectangle = Widget.Rectangle
local Color = require("quickshell.graphics.color")
local Screen = require("quickshell.screen")

-- ─── DASHBOARD LIST ──────────────────────────────────────────
-- Add your dashboards here as they're created
local dashboards = {
  {
    id = "solcmd",
    label = "⚡ SolCmd",
    command = "quickshell ~/.config/quickshell/solcmd/main.lua",
    description = "Main dashboard - system control, AI, crypto"
  },
  {
    id = "systemmonitor",
    label = "📊 System",
    command = "quickshell ~/.config/quickshell/systemmonitor/main.lua",
    description = "Resource monitor - CPU, RAM, GPU"
  },
  {
    id = "aiassistant",
    label = "🤖 AI",
    command = "quickshell ~/.config/quickshell/aiassistant/main.lua",
    description = "AI chat interface"
  },
  {
    id = "crypto",
    label = "💰 Crypto",
    command = "quickshell ~/.config/quickshell/crypto/main.lua",
    description = "Wallet and asset tracker"
  }
}

-- ─── STATE ────────────────────────────────────────────────────
local activeDashboard = nil
local navWindow = nil

-- ─── FUNCTIONS ────────────────────────────────────────────────
local function closeNav()
  if navWindow then
    navWindow.visible = false
  end
end

local function openNav()
  if not navWindow then
    navWindow = createNavWindow()
  end
  navWindow.visible = true
end

local function toggleNav()
  if navWindow and navWindow.visible then
    closeNav()
  else
    openNav()
  end
end

local function launchDashboard(dashboard)
  -- Close the nav panel
  closeNav()
  
  -- Launch the dashboard
  -- We use exec in the background so it doesn't block
  os.execute(dashboard.command .. " &")
  
  activeDashboard = dashboard.id
end

-- ─── UI CONSTRUCTION ─────────────────────────────────────────
local function createNavWindow()
  local screen = Screen.primary
  
  return Window {
    width = 320,
    height = 400,
    x = (screen.width / 2) - 160,
    y = (screen.height / 2) - 200,
    visible = false,
    anchor = { "center" },
    backgroundColor = Color.rgba(30, 30, 40, 0.95),
    borderRadius = 16,
    borderWidth = 2,
    borderColor = Color.rgba(187, 154, 247, 0.6),
    padding = 20,
    
    child = Col {
      spacing = 12,
      
      children = {
        -- Header
        Col {
          spacing = 4,
          children = {
            Label {
              text = "🧭 Navigation",
              font = "sans 20 bold",
              color = Color.rgba(255, 255, 255, 1)
            },
            Label {
              text = "Select a dashboard to launch",
              font = "sans 12",
              color = Color.rgba(255, 255, 255, 0.6)
            }
          }
        },
        
        -- Divider
        Box {
          height = 1,
          backgroundColor = Color.rgba(255, 255, 255, 0.1)
        },
        
        -- Dashboard Buttons
        Col {
          spacing = 8,
          children = (function()
            local buttons = {}
            for _, dash in ipairs(dashboards) do
              table.insert(buttons, Button {
                width = "100%",
                padding = 12,
                backgroundColor = Color.rgba(50, 50, 70, 0.8),
                hoverBackgroundColor = Color.rgba(187, 154, 247, 0.3),
                cornerRadius = 8,
                onClick = function()
                  launchDashboard(dash)
                end,
                child = Row {
                  spacing = 12,
                  children = {
                    Label {
                      text = dash.label,
                      font = "sans 14 bold",
                      color = Color.rgba(255, 255, 255, 1)
                    },
                    Label {
                      text = dash.description,
                      font = "sans 11",
                      color = Color.rgba(255, 255, 255, 0.5)
                    }
                  }
                }
              })
            end
            return buttons
          end)()
        },
        
        -- Divider
        Box {
          height = 1,
          backgroundColor = Color.rgba(255, 255, 255, 0.1)
        },
        
        -- Close button
        Button {
          padding = 8,
          backgroundColor = Color.rgba(60, 60, 80, 0.8),
          hoverBackgroundColor = Color.rgba(255, 80, 80, 0.3),
          cornerRadius = 8,
          onClick = closeNav,
          child = Label {
            text = "✕ Close (ESC)",
            font = "sans 12",
            color = Color.rgba(255, 255, 255, 0.8)
          }
        }
      }
    }
  }
end

-- ─── KEYBIND ──────────────────────────────────────────────────
-- This will be called from Hyprland or via a keybind
-- Add to Hyprland: bind = SUPER, N, exec, quickshell navCtlr/main.lua

-- If run directly, show the nav
openNav()

-- ─── HELPER ──────────────────────────────────────────────────
-- Return a function that can be called from other scripts
return {
  toggle = toggleNav,
  open = openNav,
  close = closeNav
}

-- Dual Monitor Layout
hl.monitor("DP-1", "1920x1080@144", "0x0", 1)
hl.monitor("HDMI-A-1", "1920x1080@60", "1920x0", 1)

hl.config({
  workspace = {
    "1, monitor:DP-1, default:true",
    "2, monitor:DP-1",
    "3, monitor:HDMI-A-1"
  }
})

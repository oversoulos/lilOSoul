hl.config({
  general = {
    gaps_in = 4,
    gaps_out = 8,
    border_size = 2,
    ["col.active_border"] = "rgba(bb9af7ff) rgba(7aa2f7ff) 45deg",
    ["col.inactive_border"] = "rgba(1a1b26ff)"
  },
  decoration = {
    rounding = 0, -- Sharp BSG Corners
    active_opacity = 0.98,
    inactive_opacity = 0.88,
    shadow = {
      enabled = true,
      range = 20,
      render_power = 4,
      color = "rgba(000000aa)"
    },
    blur = {
      enable = true,
      size = 6,
      passes = 3
    }
  }
})
